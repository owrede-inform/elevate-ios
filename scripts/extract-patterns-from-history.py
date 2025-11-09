#!/usr/bin/env python3
"""
Pattern Extraction from Git History
====================================

Analyzes git commit history to extract iOS adaptation patterns automatically.
Learns from how developers have adapted ELEVATE components to iOS over time.

Usage:
    python3 scripts/extract-patterns-from-history.py
    python3 scripts/extract-patterns-from-history.py --component Button
    python3 scripts/extract-patterns-from-history.py --since "2024-08-01"
"""

import argparse
import json
import re
import subprocess
import sys
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import List, Dict, Set, Optional
from collections import defaultdict


@dataclass
class PatternOccurrence:
    """Single occurrence of a pattern in the codebase"""
    file_path: str
    line_range: str
    commit_hash: str
    commit_date: str
    commit_message: str
    code_snippet: str


class PatternExtractor:
    """
    Extracts patterns from git history to build knowledge base.
    """

    def __init__(self, repo_path: Path):
        self.repo_path = repo_path
        self.knowledge_base_path = repo_path / ".elevate-knowledge" / "patterns.json"

    def run_git_command(self, args: List[str]) -> str:
        """Execute git command and return output"""
        try:
            result = subprocess.run(
                ["git"] + args,
                cwd=self.repo_path,
                capture_output=True,
                text=True,
                check=True
            )
            return result.stdout
        except subprocess.CalledProcessError as e:
            print(f"Git command failed: {e}")
            return ""

    def get_component_commits(self, component: Optional[str] = None, since: Optional[str] = None) -> List[Dict]:
        """
        Get commits that modified component files.

        Returns list of commit info: {hash, date, message, files}
        """
        args = [
            "log",
            "--pretty=format:%H|%ai|%s",
            "--name-only"
        ]

        if since:
            args.append(f"--since={since}")

        if component:
            args.append(f"-- ElevateUI/Sources/SwiftUI/Components/Elevate{component}+SwiftUI.swift")
        else:
            args.append("-- ElevateUI/Sources/SwiftUI/Components/")

        output = self.run_git_command(args)
        if not output:
            return []

        commits = []
        current_commit = None

        for line in output.split('\n'):
            if '|' in line:
                # New commit line
                parts = line.split('|', 2)
                if len(parts) == 3:
                    current_commit = {
                        'hash': parts[0],
                        'date': parts[1],
                        'message': parts[2],
                        'files': []
                    }
                    commits.append(current_commit)
            elif line.strip() and current_commit:
                # File modified in this commit
                current_commit['files'].append(line.strip())

        return commits

    def extract_hover_to_press_pattern(self) -> List[PatternOccurrence]:
        """
        Find instances where hover states were converted to press states.
        """
        occurrences = []

        # Search for commits with "hover" in message
        args = [
            "log",
            "--pretty=format:%H|%ai|%s",
            "--grep=hover",
            "-i",
            "-- ElevateUI/Sources/SwiftUI/Components/"
        ]

        output = self.run_git_command(args)
        for line in output.split('\n'):
            if not line:
                continue

            parts = line.split('|', 2)
            if len(parts) == 3:
                commit_hash, commit_date, commit_message = parts

                # Get the diff for this commit
                diff = self.run_git_command(["show", "--format=", commit_hash])

                # Look for pattern: @GestureState + isPressed
                if '@GestureState' in diff and 'isPressed' in diff:
                    # Extract the relevant code snippet
                    lines = diff.split('\n')
                    for i, diffline in enumerate(lines):
                        if '@GestureState' in diffline and 'isPressed' in diffline:
                            # Get context (10 lines)
                            snippet_lines = lines[max(0, i-5):min(len(lines), i+15)]
                            snippet = '\n'.join(snippet_lines)

                            occurrences.append(PatternOccurrence(
                                file_path="Multiple components",
                                line_range="N/A",
                                commit_hash=commit_hash[:8],
                                commit_date=commit_date.split()[0],
                                commit_message=commit_message,
                                code_snippet=snippet[:500]  # Limit size
                            ))
                            break

        return occurrences

    def extract_touch_target_pattern(self) -> List[PatternOccurrence]:
        """
        Find instances where 44pt touch targets were implemented.
        """
        occurrences = []

        # Search current codebase for touch target implementations
        components_dir = self.repo_path / "ElevateUI" / "Sources" / "SwiftUI" / "Components"

        if not components_dir.exists():
            return occurrences

        for swift_file in components_dir.glob("*.swift"):
            with open(swift_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()

            for i, line in enumerate(lines, 1):
                if 'minWidth: 44' in line or 'minHeight: 44' in line:
                    # Found a touch target implementation
                    # Get context
                    start = max(0, i - 3)
                    end = min(len(lines), i + 3)
                    snippet = ''.join(lines[start:end])

                    # Get last commit that touched this line
                    blame = self.run_git_command([
                        "blame",
                        "-L", f"{i},{i}",
                        "--porcelain",
                        swift_file.name
                    ])

                    commit_hash = ""
                    commit_date = ""
                    for blame_line in blame.split('\n'):
                        if blame_line.startswith('author-time'):
                            # Convert timestamp to date
                            timestamp = blame_line.split()[1]
                            commit_date = timestamp
                        elif not blame_line.startswith((' ', '\t')) and not '-' in blame_line:
                            commit_hash = blame_line.split()[0]
                            break

                    occurrences.append(PatternOccurrence(
                        file_path=str(swift_file.name),
                        line_range=f"{i}",
                        commit_hash=commit_hash[:8],
                        commit_date=commit_date,
                        commit_message="Touch target implementation",
                        code_snippet=snippet
                    ))

        return occurrences

    def update_knowledge_base(self, pattern_id: str, occurrences: List[PatternOccurrence]):
        """
        Update the patterns.json knowledge base with new examples.
        """
        if not self.knowledge_base_path.exists():
            print(f"Knowledge base not found: {self.knowledge_base_path}")
            return

        with open(self.knowledge_base_path, 'r') as f:
            kb = json.load(f)

        # Find the pattern
        pattern = None
        for p in kb['patterns']:
            if p['id'] == pattern_id:
                pattern = p
                break

        if not pattern:
            print(f"Pattern '{pattern_id}' not found in knowledge base")
            return

        # Add occurrences as examples
        for occ in occurrences[:5]:  # Limit to 5 examples
            example = f"{occ.file_path}:{occ.line_range} ({occ.commit_hash})"
            if example not in pattern.get('examples', []):
                if 'examples' not in pattern:
                    pattern['examples'] = []
                pattern['examples'].append(example)

        # Update last_seen date
        if occurrences:
            latest_date = max(occ.commit_date for occ in occurrences if occ.commit_date)
            if latest_date:
                pattern['last_seen'] = latest_date

        # Write back
        with open(self.knowledge_base_path, 'w') as f:
            json.dump(kb, f, indent=2)

        print(f"✅ Updated pattern '{pattern_id}' with {len(occurrences)} examples")

    def analyze_patterns(self, component: Optional[str] = None, since: Optional[str] = None):
        """
        Analyze git history and extract all patterns.
        """
        print("🔍 Pattern Extraction from Git History")
        print("=" * 50)
        print()

        # Extract hover-to-press pattern
        print("Searching for hover-to-press conversions...")
        hover_occurrences = self.extract_hover_to_press_pattern()
        print(f"  Found {len(hover_occurrences)} occurrences")
        if hover_occurrences:
            self.update_knowledge_base("hover-state-removal", hover_occurrences)

        # Extract touch target pattern
        print("\nSearching for 44pt touch target implementations...")
        touch_occurrences = self.extract_touch_target_pattern()
        print(f"  Found {len(touch_occurrences)} occurrences")
        if touch_occurrences:
            self.update_knowledge_base("touch-target-expansion", touch_occurrences)

        print("\n✅ Pattern extraction complete")
        print(f"📝 Knowledge base updated: {self.knowledge_base_path}")


def main():
    parser = argparse.ArgumentParser(
        description="Extract iOS adaptation patterns from git history"
    )
    parser.add_argument(
        "--component",
        help="Analyze specific component only"
    )
    parser.add_argument(
        "--since",
        help="Only analyze commits since this date (YYYY-MM-DD)"
    )

    args = parser.parse_args()

    repo_path = Path("/Users/wrede/Documents/GitHub/elevate-ios")
    extractor = PatternExtractor(repo_path)

    extractor.analyze_patterns(
        component=args.component,
        since=args.since
    )

    return 0


if __name__ == "__main__":
    sys.exit(main())
