#!/usr/bin/env python3
"""
iOS Human Interface Guidelines Compliance Validator
=====================================================

Validates Swift UI components against Apple HIG requirements:
- Touch targets ≥ 44pt × 44pt
- Typography ≥ 17pt for body text, ≥ 11pt minimum
- Color contrast ≥ 7:1 for text (WCAG AAA), ≥ 3:1 for UI elements
- Accessibility features (VoiceOver support, Dynamic Type)

Usage:
    python3 scripts/validate-ios-compliance.py
    python3 scripts/validate-ios-compliance.py --component Button
    python3 scripts/validate-ios-compliance.py --fix
"""

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import List, Dict, Optional
from enum import Enum


class ComplianceLevel(Enum):
    """HIG compliance levels"""
    PASS = "pass"
    WARNING = "warning"
    FAIL = "fail"


@dataclass
class ComplianceIssue:
    """Represents a single HIG compliance issue"""
    file_path: Path
    line_number: int
    rule: str
    level: ComplianceLevel
    description: str
    current_value: str
    recommended_value: str
    auto_fixable: bool = False

    def __str__(self):
        icon = "✅" if self.level == ComplianceLevel.PASS else "⚠️" if self.level == ComplianceLevel.WARNING else "❌"
        return f"{icon} {self.file_path.name}:{self.line_number} - {self.description}\n   Current: {self.current_value}\n   Recommended: {self.recommended_value}"


class iOSHIGValidator:
    """
    Validates Swift/SwiftUI components against iOS HIG.
    """

    def __init__(self, elevate_ui_path: Path):
        self.elevate_ui_path = elevate_ui_path
        self.components_dir = elevate_ui_path / "Sources" / "SwiftUI" / "Components"
        self.typography_file = elevate_ui_path / "Sources" / "Typography" / "ElevateTypographyiOS.swift"

    def validate_touch_targets(self, file_path: Path) -> List[ComplianceIssue]:
        """
        Validate that interactive elements have ≥ 44pt touch targets.

        Looks for:
        - frame(width:height:) with values < 44
        - Missing .frame(minWidth: 44, minHeight: 44)
        - Button/Toggle/etc without explicit sizing
        """
        issues = []

        with open(file_path, encoding='utf-8') as f:
            lines = f.readlines()

        for i, line in enumerate(lines, 1):
            # Check for small frame sizes
            frame_match = re.search(r'\.frame\((?:width|height):\s*(\d+(?:\.\d+)?)', line)
            if frame_match:
                size = float(frame_match.group(1))
                if size < 44:
                    issues.append(ComplianceIssue(
                        file_path=file_path,
                        line_number=i,
                        rule="HIG Touch Target Size",
                        level=ComplianceLevel.FAIL,
                        description=f"Touch target too small ({size}pt < 44pt minimum)",
                        current_value=line.strip(),
                        recommended_value=f".frame(minWidth: 44, minHeight: 44)",
                        auto_fixable=False
                    ))

            # Check for buttons without minWidth/minHeight
            if any(keyword in line for keyword in ['Button', 'Toggle', 'Picker']) and 'minWidth' not in line:
                # Look ahead to see if minWidth appears in next 5 lines
                has_min_frame = any('minWidth' in lines[j] for j in range(i, min(i+5, len(lines))))
                if not has_min_frame:
                    issues.append(ComplianceIssue(
                        file_path=file_path,
                        line_number=i,
                        rule="HIG Touch Target Size",
                        level=ComplianceLevel.WARNING,
                        description="Interactive element may not have 44pt minimum touch target",
                        current_value=line.strip(),
                        recommended_value="Add .frame(minWidth: 44, minHeight: 44)",
                        auto_fixable=False
                    ))

        return issues

    def validate_typography(self, file_path: Path) -> List[ComplianceIssue]:
        """
        Validate typography sizes meet HIG requirements.

        - Body text ≥ 17pt
        - Smallest text ≥ 11pt
        - Uses Dynamic Type when possible
        """
        issues = []

        with open(file_path, encoding='utf-8') as f:
            lines = f.readlines()

        for i, line in enumerate(lines, 1):
            # Check for custom font sizes
            font_match = re.search(r'Font\.custom\([^,]+,\s*size:\s*(\d+(?:\.\d+)?)', line)
            if font_match:
                size = float(font_match.group(1))

                # Check for body text that's too small
                if 'body' in line.lower() and size < 17:
                    issues.append(ComplianceIssue(
                        file_path=file_path,
                        line_number=i,
                        rule="HIG Typography - Body Text",
                        level=ComplianceLevel.FAIL,
                        description=f"Body text too small ({size}pt < 17pt minimum)",
                        current_value=line.strip(),
                        recommended_value=f"Use size: 17 or larger",
                        auto_fixable=False
                    ))

                # Check for any text smaller than 11pt
                elif size < 11:
                    issues.append(ComplianceIssue(
                        file_path=file_path,
                        line_number=i,
                        rule="HIG Typography - Minimum Size",
                        level=ComplianceLevel.FAIL,
                        description=f"Text too small ({size}pt < 11pt absolute minimum)",
                        current_value=line.strip(),
                        recommended_value=f"Use size: 11 or larger",
                        auto_fixable=False
                    ))

            # Check for hardcoded font sizes (should use ElevateTypography)
            if '.font(.system(size:' in line:
                issues.append(ComplianceIssue(
                    file_path=file_path,
                    line_number=i,
                    rule="Typography Token Usage",
                    level=ComplianceLevel.WARNING,
                    description="Using hardcoded system font instead of ElevateTypographyiOS",
                    current_value=line.strip(),
                    recommended_value="Use ElevateTypographyiOS.bodyMedium or similar",
                    auto_fixable=False
                ))

        return issues

    def validate_color_contrast(self, file_path: Path) -> List[ComplianceIssue]:
        """
        Validate color contrast meets WCAG AAA (7:1 for text, 3:1 for UI).

        This is a simplified check - full implementation would calculate actual contrast ratios.
        """
        issues = []

        with open(file_path, encoding='utf-8') as f:
            content = f.read()

        # Check for hardcoded colors (should use tokens)
        if re.search(r'Color\(red:|Color\.init\(red:', content):
            issues.append(ComplianceIssue(
                file_path=file_path,
                line_number=0,
                rule="Color Token Usage",
                level=ComplianceLevel.WARNING,
                description="Using hardcoded colors instead of design tokens",
                current_value="Color(red:green:blue:) or Color.init()",
                recommended_value="Use component tokens (ButtonComponentTokens.text_default)",
                auto_fixable=False
            ))

        return issues

    def validate_accessibility(self, file_path: Path) -> List[ComplianceIssue]:
        """
        Check for basic accessibility support.

        - .accessibilityLabel() for icon-only buttons
        - .accessibilityHint() for complex interactions
        - Semantic elements (Button, Toggle, not just Text + TapGesture)
        """
        issues = []

        with open(file_path, encoding='utf-8') as f:
            lines = f.readlines()

        icon_buttons = []
        for i, line in enumerate(lines, 1):
            # Detect icon-only buttons
            if 'Image(' in line or 'Icon(' in line:
                # Check if there's a Button wrapper nearby
                context = ''.join(lines[max(0, i-3):min(len(lines), i+3)])
                if 'Button' in context:
                    # Check for accessibilityLabel
                    has_label = any('accessibilityLabel' in lines[j]
                                    for j in range(max(0, i-5), min(i+5, len(lines))))
                    if not has_label:
                        issues.append(ComplianceIssue(
                            file_path=file_path,
                            line_number=i,
                            rule="Accessibility Label",
                            level=ComplianceLevel.WARNING,
                            description="Icon button missing .accessibilityLabel()",
                            current_value=line.strip(),
                            recommended_value="Add .accessibilityLabel(\"descriptive label\")",
                            auto_fixable=False
                        ))

        return issues

    def validate_component(self, file_path: Path) -> List[ComplianceIssue]:
        """
        Run all validation rules on a component file.
        """
        issues = []

        issues.extend(self.validate_touch_targets(file_path))
        issues.extend(self.validate_typography(file_path))
        issues.extend(self.validate_color_contrast(file_path))
        issues.extend(self.validate_accessibility(file_path))

        return issues

    def validate_all_components(self) -> Dict[str, List[ComplianceIssue]]:
        """
        Validate all SwiftUI components.

        Returns:
            Dict mapping component name to list of issues
        """
        results = {}

        if not self.components_dir.exists():
            print(f"❌ Components directory not found: {self.components_dir}")
            return results

        for component_file in self.components_dir.glob("Elevate*+SwiftUI.swift"):
            issues = self.validate_component(component_file)
            if issues:
                results[component_file.stem] = issues

        return results

    def generate_report(self, results: Dict[str, List[ComplianceIssue]]) -> str:
        """
        Generate human-readable validation report.
        """
        lines = []

        total_issues = sum(len(issues) for issues in results.values())
        fail_count = sum(1 for issues in results.values() for i in issues if i.level == ComplianceLevel.FAIL)
        warn_count = sum(1 for issues in results.values() for i in issues if i.level == ComplianceLevel.WARNING)

        lines.append("=" * 70)
        lines.append("iOS HIG Compliance Validation Report")
        lines.append("=" * 70)
        lines.append("")
        lines.append(f"Total Issues: {total_issues}")
        lines.append(f"  ❌ Failures: {fail_count}")
        lines.append(f"  ⚠️  Warnings: {warn_count}")
        lines.append("")

        if not results:
            lines.append("✅ All components pass HIG compliance checks!")
            return "\n".join(lines)

        lines.append("Components with Issues:")
        lines.append("")

        for component, issues in sorted(results.items()):
            lines.append(f"📄 {component}")
            lines.append("-" * 70)
            for issue in sorted(issues, key=lambda x: (x.level.value, x.line_number)):
                lines.append(str(issue))
                lines.append("")

        lines.append("=" * 70)
        lines.append("Recommendations:")
        lines.append("  1. Fix all ❌ FAIL issues - these violate HIG requirements")
        lines.append("  2. Review ⚠️  WARNING issues - consider addressing for best practices")
        lines.append("  3. Use ElevateTypographyiOS for all text sizing")
        lines.append("  4. Use component tokens for all colors")
        lines.append("  5. Ensure all interactive elements have 44pt minimum touch target")
        lines.append("")

        return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(
        description="Validate iOS HIG compliance for ElevateUI components"
    )
    parser.add_argument(
        "--component",
        help="Validate specific component (e.g., 'Button')"
    )
    parser.add_argument(
        "--fix",
        action="store_true",
        help="Auto-fix issues where possible (not yet implemented)"
    )
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        help="Output report to file"
    )

    args = parser.parse_args()

    elevate_ui_path = Path("/Users/wrede/Documents/GitHub/elevate-ios/ElevateUI")
    validator = iOSHIGValidator(elevate_ui_path)

    print("🔍 iOS HIG Compliance Validator")
    print("=" * 50)
    print()

    if args.component:
        component_file = elevate_ui_path / "Sources" / "SwiftUI" / "Components" / f"Elevate{args.component}+SwiftUI.swift"
        if not component_file.exists():
            print(f"❌ Component not found: {component_file}")
            return 1

        issues = validator.validate_component(component_file)
        results = {args.component: issues} if issues else {}
    else:
        print("Validating all components...")
        results = validator.validate_all_components()

    report = validator.generate_report(results)
    print(report)

    if args.output:
        args.output.write_text(report)
        print(f"\n📝 Report saved to: {args.output}")

    # Exit with error code if there are failures
    fail_count = sum(1 for issues in results.values() for i in issues if i.level == ComplianceLevel.FAIL)
    return 1 if fail_count > 0 else 0


if __name__ == "__main__":
    sys.exit(main())
