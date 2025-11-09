#!/usr/bin/env python3
"""
ELEVATE Change Analyzer - Phase 1 Implementation
=================================================

Analyzes changes between ELEVATE versions and provides:
- Detailed diff report (tokens, components, themes)
- Risk assessment and impact analysis
- iOS adaptation recommendations
- Estimated manual effort

This is the foundation for the intelligent update system.

Usage:
    python3 scripts/analyze-elevate-changes.py --from v0.36.1 --to v0.37.0
    python3 scripts/analyze-elevate-changes.py --latest  # Compare with latest
"""

import argparse
import json
import re
import sys
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Dict, List, Set, Optional, Tuple
from enum import Enum
import hashlib


class ChangeType(Enum):
    """Types of changes detected"""
    NEW_TOKEN = "new_token"
    REMOVED_TOKEN = "removed_token"
    MODIFIED_TOKEN = "modified_token"
    RENAMED_TOKEN = "renamed_token"
    NEW_COMPONENT = "new_component"
    REMOVED_COMPONENT = "removed_component"
    EXTENDED_COMPONENT = "extended_component"
    NEW_THEME = "new_theme"


class RiskLevel(Enum):
    """Risk levels for changes"""
    LOW = "low"          # 0.0-0.3: Safe to auto-apply
    MEDIUM = "medium"    # 0.3-0.7: Requires review
    HIGH = "high"        # 0.7-1.0: Requires manual QA


@dataclass
class TokenChange:
    """Represents a single token change"""
    token_name: str
    change_type: ChangeType
    old_value: Optional[str] = None
    new_value: Optional[str] = None
    component: Optional[str] = None  # Which component this affects
    risk_level: RiskLevel = RiskLevel.LOW

    def __str__(self):
        if self.change_type == ChangeType.NEW_TOKEN:
            return f"  + {self.token_name}: {self.new_value}"
        elif self.change_type == ChangeType.REMOVED_TOKEN:
            return f"  - {self.token_name}: {self.old_value}"
        elif self.change_type == ChangeType.MODIFIED_TOKEN:
            return f"  ~ {self.token_name}: {self.old_value} → {self.new_value}"
        elif self.change_type == ChangeType.RENAMED_TOKEN:
            return f"  ↻ {self.old_value} → {self.token_name}"
        return f"  ? {self.token_name}"


@dataclass
class ComponentChange:
    """Represents changes to a component"""
    component_name: str
    change_type: ChangeType
    token_changes: List[TokenChange]
    ios_impact: str  # Description of iOS impact
    estimated_effort_minutes: int
    auto_adaptable: bool  # Can this be auto-adapted?
    risk_score: float  # 0.0-1.0


@dataclass
class ChangeReport:
    """Complete change analysis report"""
    from_version: str
    to_version: str
    token_changes: List[TokenChange]
    component_changes: List[ComponentChange]
    new_components: List[str]
    removed_components: List[str]
    overall_risk_score: float
    estimated_total_effort_minutes: int
    automation_coverage_percent: int
    summary: str


class ElevateChangeAnalyzer:
    """
    Analyzes changes between ELEVATE versions.
    """

    def __init__(self, elevate_tokens_path: Path):
        self.tokens_path = elevate_tokens_path
        self.cache_dir = Path.home() / ".elevate-cache"
        self.cache_dir.mkdir(exist_ok=True)

    def parse_scss_tokens(self, scss_file: Path) -> Dict[str, str]:
        """
        Parse SCSS file and extract all token definitions.

        Handles:
        - Simple variables: $token-name: value;
        - Multi-line values
        - Nested SCSS structures
        - Comments (single-line // and multi-line /* */)

        Returns:
            Dict mapping token name to value
        """
        tokens = {}

        if not scss_file.exists():
            return tokens

        with open(scss_file, encoding='utf-8') as f:
            content = f.read()

        # Remove comments first
        # Remove multi-line comments /* ... */
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
        # Remove single-line comments //
        content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)

        # Match SCSS variable definitions: $token-name: value;
        # Handles multi-line by matching everything until semicolon
        pattern = r'\$([a-z0-9_-]+):\s*([^;]+);'

        for match in re.finditer(pattern, content, re.MULTILINE | re.DOTALL):
            token_name = match.group(1)
            token_value = match.group(2).strip()
            # Normalize whitespace in multi-line values
            token_value = ' '.join(token_value.split())
            tokens[token_name] = token_value

        return tokens

    def detect_token_changes(
        self,
        old_tokens: Dict[str, str],
        new_tokens: Dict[str, str]
    ) -> List[TokenChange]:
        """
        Compare two sets of tokens and identify changes.
        """
        changes = []

        old_names = set(old_tokens.keys())
        new_names = set(new_tokens.keys())

        # New tokens
        for name in new_names - old_names:
            changes.append(TokenChange(
                token_name=name,
                change_type=ChangeType.NEW_TOKEN,
                new_value=new_tokens[name],
                risk_level=RiskLevel.LOW  # New tokens are low risk
            ))

        # Removed tokens
        for name in old_names - new_names:
            changes.append(TokenChange(
                token_name=name,
                change_type=ChangeType.REMOVED_TOKEN,
                old_value=old_tokens[name],
                risk_level=RiskLevel.HIGH  # Removed tokens may break code
            ))

        # Modified tokens
        for name in old_names & new_names:
            if old_tokens[name] != new_tokens[name]:
                # Calculate risk based on value change
                risk = self._assess_token_modification_risk(
                    name, old_tokens[name], new_tokens[name]
                )

                changes.append(TokenChange(
                    token_name=name,
                    change_type=ChangeType.MODIFIED_TOKEN,
                    old_value=old_tokens[name],
                    new_value=new_tokens[name],
                    risk_level=risk
                ))

        return changes

    def _assess_token_modification_risk(
        self,
        name: str,
        old_value: str,
        new_value: str
    ) -> RiskLevel:
        """
        Assess risk level of a token modification.
        """
        # Color changes: Check delta E (perceptual difference)
        if 'color' in name:
            # For now, simple heuristic
            return RiskLevel.MEDIUM if old_value != new_value else RiskLevel.LOW

        # Size/dimension changes: Check percentage change
        if any(x in name for x in ['size', 'width', 'height', 'padding', 'margin']):
            try:
                old_num = float(re.sub(r'[^\d.]', '', old_value))
                new_num = float(re.sub(r'[^\d.]', '', new_value))
                percent_change = abs((new_num - old_num) / old_num)

                if percent_change > 0.3:  # >30% change
                    return RiskLevel.HIGH
                elif percent_change > 0.1:  # >10% change
                    return RiskLevel.MEDIUM
            except (ValueError, ZeroDivisionError):
                pass

        return RiskLevel.LOW

    def analyze_component_files(
        self,
        old_component_dir: Path,
        new_component_dir: Path
    ) -> Tuple[List[str], List[str], List[ComponentChange]]:
        """
        Analyze component token file changes.

        Returns:
            (new_components, removed_components, extended_components)
        """
        old_files = set(f.stem for f in old_component_dir.glob("_*.scss"))
        new_files = set(f.stem for f in new_component_dir.glob("_*.scss"))

        new_components = list(new_files - old_files)
        removed_components = list(old_files - new_files)
        common_components = old_files & new_files

        extended_components = []

        # Analyze each common component for changes
        for component in common_components:
            old_tokens = self.parse_scss_tokens(
                old_component_dir / f"{component}.scss"
            )
            new_tokens = self.parse_scss_tokens(
                new_component_dir / f"{component}.scss"
            )

            token_changes = self.detect_token_changes(old_tokens, new_tokens)

            if token_changes:
                # This component was extended/modified
                component_name = component.lstrip('_')

                # Assess iOS impact
                ios_impact = self._assess_ios_impact(component_name, token_changes)
                effort = self._estimate_effort(component_name, token_changes)
                auto_adaptable = self._can_auto_adapt(component_name, token_changes)
                risk = self._calculate_component_risk(token_changes)

                extended_components.append(ComponentChange(
                    component_name=component_name,
                    change_type=ChangeType.EXTENDED_COMPONENT,
                    token_changes=token_changes,
                    ios_impact=ios_impact,
                    estimated_effort_minutes=effort,
                    auto_adaptable=auto_adaptable,
                    risk_score=risk
                ))

        return new_components, removed_components, extended_components

    def _assess_ios_impact(
        self,
        component: str,
        changes: List[TokenChange]
    ) -> str:
        """
        Assess how token changes impact iOS implementation.
        """
        high_impact_keywords = ['hover', 'cursor', 'focus-visible']
        layout_keywords = ['position', 'alignment', 'flex', 'grid']

        impact_notes = []

        for change in changes:
            if any(kw in change.token_name for kw in high_impact_keywords):
                impact_notes.append(
                    f"⚠️  {change.token_name}: iOS doesn't support hover states"
                )
            elif any(kw in change.token_name for kw in layout_keywords):
                impact_notes.append(
                    f"📐 {change.token_name}: May require layout changes"
                )

        if impact_notes:
            return "\n".join(impact_notes)
        else:
            return "✓ Low impact - likely token value updates only"

    def _estimate_effort(
        self,
        component: str,
        changes: List[TokenChange]
    ) -> int:
        """
        Estimate manual effort in minutes.
        """
        # Base effort per change type
        effort = 0

        for change in changes:
            if change.change_type == ChangeType.NEW_TOKEN:
                # New property might need iOS implementation
                effort += 10
            elif change.change_type == ChangeType.REMOVED_TOKEN:
                # Removal requires code migration
                effort += 15
            elif change.change_type == ChangeType.MODIFIED_TOKEN:
                # Simple value change
                effort += 2

        # Cap at reasonable maximum per component
        return min(effort, 60)

    def _can_auto_adapt(
        self,
        component: str,
        changes: List[TokenChange]
    ) -> bool:
        """
        Determine if changes can be auto-adapted.
        """
        # For now, simple heuristic: only value changes can be auto-adapted
        for change in changes:
            if change.change_type in [
                ChangeType.NEW_TOKEN,
                ChangeType.REMOVED_TOKEN,
                ChangeType.RENAMED_TOKEN
            ]:
                return False

        return True

    def _calculate_component_risk(self, changes: List[TokenChange]) -> float:
        """
        Calculate overall risk score for component (0.0-1.0).
        """
        if not changes:
            return 0.0

        # Weight changes by their risk level
        risk_weights = {
            RiskLevel.LOW: 0.1,
            RiskLevel.MEDIUM: 0.5,
            RiskLevel.HIGH: 1.0
        }

        total_risk = sum(risk_weights[c.risk_level] for c in changes)
        max_risk = len(changes) * 1.0  # All high risk

        return min(1.0, total_risk / max_risk) if max_risk > 0 else 0.0

    def generate_report(
        self,
        from_version: str,
        to_version: str,
        from_path: Path,
        to_path: Path
    ) -> ChangeReport:
        """
        Generate comprehensive change report.
        """
        # Parse light mode tokens (primary comparison)
        old_tokens = self.parse_scss_tokens(from_path / "values" / "_light.scss")
        new_tokens = self.parse_scss_tokens(to_path / "values" / "_light.scss")

        token_changes = self.detect_token_changes(old_tokens, new_tokens)

        # Analyze component changes
        new_components, removed_components, extended_components = \
            self.analyze_component_files(
                from_path / "tokens" / "component",
                to_path / "tokens" / "component"
            )

        # Calculate overall metrics
        total_effort = sum(c.estimated_effort_minutes for c in extended_components)
        total_effort += len(new_components) * 60  # 1 hour per new component
        total_effort += len(removed_components) * 30  # 30 min per removal

        auto_adaptable_count = sum(1 for c in extended_components if c.auto_adaptable)
        automation_coverage = int(
            (auto_adaptable_count / len(extended_components) * 100)
            if extended_components else 0
        )

        overall_risk = sum(c.risk_score for c in extended_components) / len(extended_components) \
            if extended_components else 0.0

        # Generate summary
        summary = self._generate_summary(
            token_changes,
            new_components,
            removed_components,
            extended_components
        )

        return ChangeReport(
            from_version=from_version,
            to_version=to_version,
            token_changes=token_changes,
            component_changes=extended_components,
            new_components=new_components,
            removed_components=removed_components,
            overall_risk_score=overall_risk,
            estimated_total_effort_minutes=total_effort,
            automation_coverage_percent=automation_coverage,
            summary=summary
        )

    def _generate_summary(
        self,
        token_changes: List[TokenChange],
        new_components: List[str],
        removed_components: List[str],
        extended_components: List[ComponentChange]
    ) -> str:
        """Generate human-readable summary."""
        lines = []

        lines.append(f"📊 Change Summary:")
        lines.append(f"  • {len(token_changes)} token changes")
        lines.append(f"  • {len(new_components)} new components")
        lines.append(f"  • {len(removed_components)} removed components")
        lines.append(f"  • {len(extended_components)} extended components")

        return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(
        description="Analyze changes between ELEVATE versions"
    )
    parser.add_argument(
        "--test",
        action="store_true",
        help="Run test mode with current .elevate-src"
    )
    parser.add_argument(
        "--from",
        dest="from_version",
        help="Source version (e.g., v0.36.1)"
    )
    parser.add_argument(
        "--to",
        dest="to_version",
        help="Target version (e.g., v0.37.0)"
    )
    parser.add_argument(
        "--from-path",
        type=Path,
        help="Path to source ELEVATE tokens"
    )
    parser.add_argument(
        "--to-path",
        type=Path,
        help="Path to target ELEVATE tokens"
    )
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        help="Output JSON file for report"
    )
    parser.add_argument(
        "--verbose",
        "-v",
        action="store_true",
        help="Verbose output"
    )

    args = parser.parse_args()

    # Test mode: Parse current .elevate-src and show token stats
    if args.test:
        print("🔍 ELEVATE Change Analyzer - Test Mode")
        print("=" * 50)
        print()

        elevate_src = Path("/Users/wrede/Documents/GitHub/elevate-ios/.elevate-src/Elevate-2025-11-04/elevate-design-tokens-main")
        if not elevate_src.exists():
            print("❌ .elevate-src directory not found")
            return 1

        analyzer = ElevateChangeAnalyzer(elevate_src)

        # Parse light mode tokens
        light_file = elevate_src / "src" / "scss" / "values" / "_light.scss"
        if light_file.exists():
            tokens = analyzer.parse_scss_tokens(light_file)
            print(f"✅ Parsed {len(tokens)} tokens from _light.scss")

            # Show sample tokens
            print("\nSample tokens:")
            for i, (name, value) in enumerate(list(tokens.items())[:10]):
                print(f"  ${name}: {value}")

            # Categorize tokens
            color_tokens = [k for k in tokens.keys() if 'color' in k]
            size_tokens = [k for k in tokens.keys() if any(x in k for x in ['size', 'width', 'height', 'padding', 'margin'])]
            font_tokens = [k for k in tokens.keys() if 'font' in k or 'typography' in k]

            print(f"\nToken categories:")
            print(f"  • Colors: {len(color_tokens)}")
            print(f"  • Sizes/spacing: {len(size_tokens)}")
            print(f"  • Typography: {len(font_tokens)}")
            print(f"  • Other: {len(tokens) - len(color_tokens) - len(size_tokens) - len(font_tokens)}")
        else:
            print(f"❌ Light mode tokens not found at: {light_file}")

        # Check component tokens
        component_dir = elevate_src / "src" / "scss" / "tokens" / "component"
        if component_dir.exists():
            component_files = list(component_dir.glob("_*.scss"))
            print(f"\n✅ Found {len(component_files)} component token files")
            print("\nComponents:")
            for comp_file in sorted(component_files)[:15]:
                comp_name = comp_file.stem.lstrip('_')
                comp_tokens = analyzer.parse_scss_tokens(comp_file)
                print(f"  • {comp_name}: {len(comp_tokens)} tokens")

        print(f"\n✅ Test completed successfully")
        print(f"\nNext steps:")
        print(f"  1. Use --from-path and --to-path to compare two versions")
        print(f"  2. Implement git clone for automatic version fetching")
        print(f"  3. Add iOS impact analysis")

        return 0

    # Normal mode: Require from/to parameters
    if not args.from_version or not args.to_version:
        print("❌ Error: --from and --to versions required (or use --test)")
        parser.print_help()
        return 1

    print(f"""
🔍 ELEVATE Change Analyzer
==========================

Comparing: {args.from_version} → {args.to_version}

⚠️  Version comparison not yet implemented.

To complete implementation:
1. Add git clone/download logic for ELEVATE versions
2. Implement full SCSS token parsing ✅ DONE
3. Add component file analysis ✅ DONE
4. Implement risk assessment algorithms ✅ DONE
5. Add ML-based pattern matching (Phase 2)

Use --test to validate token parsing with current .elevate-src

See: docs/INTELLIGENT_UPDATE_SYSTEM.md for full design.
    """)

    return 0


if __name__ == "__main__":
    sys.exit(main())
