#!/usr/bin/env python3
"""
SCSS Change Detector
====================

Detects which SCSS/CSS files have changed since last regeneration.
Uses MD5 hashing for fast change detection without parsing.

This enables:
- Skip regeneration if nothing changed
- Selective regeneration of only changed tokens
- Map SCSS files to Swift files for targeted updates
"""

import hashlib
import json
from pathlib import Path
from typing import Dict, Set, List, Optional
from datetime import datetime

# Paths
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
ELEVATE_TOKENS_PATH = Path("/Users/wrede/Documents/GitHub/elevate-ios/.elevate-src/Elevate-2025-11-04/elevate-design-tokens-main/src/scss")
THEME_PATH = PROJECT_ROOT / ".elevate-themes" / "ios"
CACHE_FILE = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens" / ".token_cache.json"


class SCSSChangeDetector:
    """
    Detects changes in SCSS/CSS source files.

    Uses MD5 hashing for performance:
    - Hash computation: O(file_size)
    - Comparison: O(1)
    - No parsing required

    Much faster than parsing + comparison for large files.
    """

    def __init__(self, cache_file: Path = CACHE_FILE):
        self.cache_file = cache_file
        self.cache = self._load_cache()
        self.scss_to_swift_map = self._build_scss_to_swift_map()

    def _load_cache(self) -> Dict:
        """Load cached file hashes"""
        if self.cache_file.exists():
            try:
                with open(self.cache_file, 'r') as f:
                    return json.load(f)
            except json.JSONDecodeError:
                print(f"⚠️  Cache file corrupted, will regenerate")
                return {}
        return {}

    def _save_cache(self):
        """Save file hashes to cache"""
        self.cache_file.parent.mkdir(parents=True, exist_ok=True)
        with open(self.cache_file, 'w') as f:
            json.dump(self.cache, f, indent=2)

    def _compute_hash(self, file_path: Path) -> str:
        """Compute MD5 hash of file contents"""
        if not file_path.exists():
            return ""

        md5 = hashlib.md5()
        with open(file_path, 'rb') as f:
            for chunk in iter(lambda: f.read(4096), b""):
                md5.update(chunk)
        return md5.hexdigest()

    def _build_scss_to_swift_map(self) -> Dict[str, List[str]]:
        """
        Map SCSS source files to generated Swift files.

        This mapping determines which Swift files need regeneration
        when a specific SCSS file changes.
        """
        return {
            # Core token files
            "_light.scss": ["ElevatePrimitives.swift", "ElevateAliases.swift"],
            "_dark.scss": ["ElevatePrimitives.swift", "ElevateAliases.swift"],

            # iOS theme files
            "primitives.css": ["ElevatePrimitives.swift"],
            "extend.css": ["ElevateAliases.swift"],
            "overrides.css": ["*ComponentTokens.swift"],  # All components
            "overwrite.css": ["*ComponentTokens.swift"],  # All components
            "overwrite-dark.css": ["*ComponentTokens.swift"],  # All components

            # Component token files (with underscores to match actual filenames)
            "_button.scss": ["ButtonComponentTokens.swift"],
            "_card.scss": ["CardComponentTokens.swift"],
            "_input.scss": ["InputComponentTokens.swift"],
            "_badge.scss": ["BadgeComponentTokens.swift"],
            "_chip.scss": ["ChipComponentTokens.swift"],
            "_avatar.scss": ["AvatarComponentTokens.swift"],
            "_checkbox.scss": ["CheckboxComponentTokens.swift"],
            "_switch.scss": ["SwitchComponentTokens.swift"],
            "_slider.scss": ["SliderComponentTokens.swift"],
            "_radio.scss": ["RadioComponentTokens.swift"],
            "_select.scss": ["SelectComponentTokens.swift"],
            "_dropdown.scss": ["DropdownComponentTokens.swift"],
            "_menu.scss": ["MenuComponentTokens.swift", "Menu-itemComponentTokens.swift"],
            "_tab.scss": ["TabComponentTokens.swift"],
            "_breadcrumb.scss": ["BreadcrumbComponentTokens.swift", "Breadcrumb-itemComponentTokens.swift"],
            "_link.scss": ["LinkComponentTokens.swift"],
            "_dialog.scss": ["DialogComponentTokens.swift"],
            "_drawer.scss": ["DrawerComponentTokens.swift"],
            "_lightbox.scss": ["LightboxComponentTokens.swift"],
            "_tooltip.scss": ["TooltipComponentTokens.swift"],
            "_notification.scss": ["NotificationComponentTokens.swift"],
            "_progress.scss": ["ProgressComponentTokens.swift"],
            "_indicator.scss": ["IndicatorComponentTokens.swift"],
            "_skeleton.scss": ["SkeletonComponentTokens.swift"],
            "_stepper.scss": ["StepperComponentTokens.swift"],
            "_paginator.scss": ["PaginatorComponentTokens.swift"],
            "_table.scss": ["TableComponentTokens.swift"],
            "_tree.scss": ["TreeComponentTokens.swift", "Tree-itemComponentTokens.swift"],
            "_field.scss": ["FieldComponentTokens.swift"],
            "_textarea.scss": ["TextareaComponentTokens.swift"],
            "_icon.scss": ["IconComponentTokens.swift"],
            "_application.scss": ["ApplicationComponentTokens.swift"],
            "_scrollbar.scss": ["ScrollbarComponentTokens.swift"],
            "_button-group.scss": ["Button-groupComponentTokens.swift"],
            "_icon-button.scss": ["Icon-buttonComponentTokens.swift"],
            "_radio-button.scss": ["Radio-buttonComponentTokens.swift"],
            "_radio-group.scss": ["Radio-groupComponentTokens.swift"],
            "_expansion-panel.scss": ["Expansion-panelComponentTokens.swift"],
            "_select-option.scss": ["Select-optionComponentTokens.swift"],
            "_select-option-group.scss": ["Select-option-groupComponentTokens.swift"],
            "_breadcrumb-item.scss": ["Breadcrumb-itemComponentTokens.swift"],
            "_menu-item.scss": ["Menu-itemComponentTokens.swift"],
            "_tree-item.scss": ["Tree-itemComponentTokens.swift"],
            "_stepper-item.scss": ["StepperComponentTokens.swift"],  # Maps to main Stepper
            "_tab-group.scss": ["TabComponentTokens.swift"],  # Maps to main Tab

            # Typography
            "_typography.scss": ["ElevateTypography.swift", "ElevateTypographyiOS.swift"],
        }

    def find_source_files(self) -> List[Path]:
        """Find all SCSS/CSS source files"""
        files = []

        # ELEVATE core tokens
        if ELEVATE_TOKENS_PATH.exists():
            light_file = ELEVATE_TOKENS_PATH / "values" / "_light.scss"
            dark_file = ELEVATE_TOKENS_PATH / "values" / "_dark.scss"
            if light_file.exists():
                files.append(light_file)
            if dark_file.exists():
                files.append(dark_file)

            # Component tokens
            component_dir = ELEVATE_TOKENS_PATH / "tokens" / "component"
            if component_dir.exists():
                files.extend(component_dir.glob("*.scss"))

        # iOS theme files
        if THEME_PATH.exists():
            for theme_file in ["primitives.css", "extend.css", "overrides.css", "overwrite.css", "overwrite-dark.css"]:
                file_path = THEME_PATH / theme_file
                if file_path.exists():
                    files.append(file_path)

        return files

    def detect_changes(self) -> Dict[str, bool]:
        """
        Detect which source files have changed.

        Returns:
            Dict mapping file paths to changed status (True = changed)
        """
        changes = {}
        source_files = self.find_source_files()

        for file_path in source_files:
            file_key = str(file_path)
            current_hash = self._compute_hash(file_path)
            cached_hash = self.cache.get(file_key, {}).get("hash", "")

            is_changed = current_hash != cached_hash
            changes[file_key] = is_changed

            # Update cache
            if file_key not in self.cache:
                self.cache[file_key] = {}

            self.cache[file_key]["hash"] = current_hash
            self.cache[file_key]["last_checked"] = datetime.now().isoformat()

            if is_changed:
                self.cache[file_key]["last_changed"] = datetime.now().isoformat()

        return changes

    def get_changed_swift_files(self) -> Set[str]:
        """
        Get set of Swift files that need regeneration based on SCSS changes.

        Returns:
            Set of Swift file names to regenerate
        """
        changes = self.detect_changes()
        changed_scss = [Path(f).name for f, changed in changes.items() if changed]

        if not changed_scss:
            return set()

        swift_files = set()

        for scss_file in changed_scss:
            mapped_files = self.scss_to_swift_map.get(scss_file, [])

            for swift_file in mapped_files:
                if swift_file == "*ComponentTokens.swift":
                    # Map to all component files
                    from token_dependency_graph import TokenDependencyGraph
                    graph = TokenDependencyGraph()
                    all_files = graph.get_all_files()
                    swift_files.update([f for f in all_files if "ComponentTokens" in f])
                else:
                    swift_files.add(swift_file)

        return swift_files

    def update_cache(self):
        """Save current state to cache"""
        self._save_cache()

    def clear_cache(self):
        """Clear the cache (forces full regeneration next time)"""
        self.cache = {}
        self._save_cache()

    def print_status(self):
        """Print change detection status"""
        # Get changes without updating cache
        source_files = self.find_source_files()
        changes = {}

        for file_path in source_files:
            file_key = str(file_path)
            current_hash = self._compute_hash(file_path)
            cached_hash = self.cache.get(file_key, {}).get("hash", "")
            changes[file_key] = (current_hash != cached_hash)

        changed = {f: c for f, c in changes.items() if c}

        print("SCSS Change Detection Status")
        print("=" * 60)
        print(f"Total source files: {len(changes)}")
        print(f"Changed files: {len(changed)}")
        print()

        if changed:
            print("Changed SCSS files:")
            for file in changed:
                file_name = Path(file).name
                print(f"  ✨ {file_name}")

            print()
            # Get Swift files that need regeneration
            changed_scss = [Path(f).name for f, c in changes.items() if c]
            swift_files = set()

            for scss_file in changed_scss:
                mapped_files = self.scss_to_swift_map.get(scss_file, [])
                for swift_file in mapped_files:
                    if swift_file == "*ComponentTokens.swift":
                        from token_dependency_graph import TokenDependencyGraph
                        graph = TokenDependencyGraph()
                        all_files = graph.get_all_files()
                        swift_files.update([f for f in all_files if "ComponentTokens" in f])
                    else:
                        swift_files.add(swift_file)

            print(f"Swift files to regenerate: {len(swift_files)}")
            for file in sorted(swift_files):
                print(f"  → {file}")
        else:
            print("✅ No changes detected - regeneration not needed!")


def main():
    """CLI for change detection"""
    import argparse

    parser = argparse.ArgumentParser(description='SCSS Change Detector')
    parser.add_argument('--status', action='store_true', help='Show change status')
    parser.add_argument('--clear-cache', action='store_true', help='Clear cache')
    parser.add_argument('--list-sources', action='store_true', help='List all source files')

    args = parser.parse_args()

    detector = SCSSChangeDetector()

    if args.clear_cache:
        detector.clear_cache()
        print("✅ Cache cleared - next regeneration will be full")
        return

    if args.list_sources:
        print("SCSS/CSS Source Files")
        print("=" * 60)
        files = detector.find_source_files()
        for file in files:
            print(f"  • {file.relative_to(PROJECT_ROOT) if file.is_relative_to(PROJECT_ROOT) else file}")
        print(f"\nTotal: {len(files)} files")
        return

    if args.status:
        detector.print_status()
        return

    # Default: detect changes and show summary
    detector.print_status()


if __name__ == '__main__':
    main()
