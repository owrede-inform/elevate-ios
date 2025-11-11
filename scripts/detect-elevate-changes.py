#!/usr/bin/env python3
"""
ELEVATE Change Detection Engine
================================

Analyzes changes between ELEVATE design token versions to:
- Detect what changed (colors, spacing, components, etc.)
- Calculate risk score (LOW, MEDIUM, HIGH)
- Provide impact analysis
- Generate change report

This enables intelligent decision-making for token updates.
"""

import re
import json
from pathlib import Path
from typing import Dict, List, Set, Tuple, Optional
from dataclasses import dataclass, asdict
from enum import Enum
import sys

# Add scripts to path
SCRIPT_DIR = Path(__file__).parent
sys.path.insert(0, str(SCRIPT_DIR))

from scss_change_detector import SCSSChangeDetector
from token_dependency_graph import TokenDependencyGraph


class RiskLevel(Enum):
    """Risk level for token updates"""
    LOW = "LOW"
    MEDIUM = "MEDIUM"
    HIGH = "HIGH"
    CRITICAL = "CRITICAL"


class ChangeType(Enum):
    """Type of change detected"""
    COLOR_VALUE = "color_value"
    SPACING_VALUE = "spacing_value"
    COMPONENT_TOKEN = "component_token"
    PRIMITIVE_TOKEN = "primitive_token"
    ALIAS_TOKEN = "alias_token"
    NEW_TOKEN = "new_token"
    REMOVED_TOKEN = "removed_token"
    TYPOGRAPHY = "typography"


@dataclass
class TokenChange:
    """Represents a single token change"""
    token_name: str
    change_type: ChangeType
    old_value: Optional[str]
    new_value: Optional[str]
    file: str
    line: Optional[int] = None

    @property
    def is_breaking(self) -> bool:
        """Check if this is a breaking change"""
        return self.change_type in [ChangeType.REMOVED_TOKEN, ChangeType.PRIMITIVE_TOKEN]

    @property
    def risk_weight(self) -> float:
        """Weight for risk calculation"""
        weights = {
            ChangeType.REMOVED_TOKEN: 10.0,
            ChangeType.PRIMITIVE_TOKEN: 8.0,
            ChangeType.ALIAS_TOKEN: 5.0,
            ChangeType.COLOR_VALUE: 3.0,
            ChangeType.COMPONENT_TOKEN: 2.0,
            ChangeType.SPACING_VALUE: 2.0,
            ChangeType.TYPOGRAPHY: 2.0,
            ChangeType.NEW_TOKEN: 1.0,
        }
        return weights.get(self.change_type, 1.0)


@dataclass
class ChangeReport:
    """Complete change analysis report"""
    changed_files: List[str]
    changes: List[TokenChange]
    swift_files_affected: List[str]
    risk_level: RiskLevel
    risk_score: float
    summary: str
    recommendations: List[str]

    def to_dict(self) -> Dict:
        """Convert to dictionary for JSON serialization"""
        return {
            'changed_files': self.changed_files,
            'changes': [asdict(c) for c in self.changes],
            'swift_files_affected': self.swift_files_affected,
            'risk_level': self.risk_level.value,
            'risk_score': self.risk_score,
            'summary': self.summary,
            'recommendations': self.recommendations
        }


class ElevateChangeDetector:
    """
    Detects and analyzes changes in ELEVATE design tokens.

    Provides:
    - Change detection (what changed)
    - Risk scoring (how risky is the update)
    - Impact analysis (what will be affected)
    - Actionable recommendations
    """

    def __init__(self):
        self.scss_detector = SCSSChangeDetector()
        self.dependency_graph = TokenDependencyGraph()

    def detect_changes(self) -> ChangeReport:
        """
        Detect changes and generate comprehensive report.

        Returns:
            ChangeReport with full analysis
        """
        # Get changed SCSS files
        scss_changes = self.scss_detector.detect_changes()
        changed_files = [f for f, changed in scss_changes.items() if changed]

        if not changed_files:
            return ChangeReport(
                changed_files=[],
                changes=[],
                swift_files_affected=[],
                risk_level=RiskLevel.LOW,
                risk_score=0.0,
                summary="No changes detected",
                recommendations=["No action needed"]
            )

        # Analyze each changed file
        changes: List[TokenChange] = []
        for file_path in changed_files:
            file_changes = self._analyze_file(Path(file_path))
            changes.extend(file_changes)

        # Get affected Swift files
        swift_files = self.scss_detector.get_changed_swift_files()

        # Calculate risk
        risk_score = self._calculate_risk_score(changes, swift_files)
        risk_level = self._determine_risk_level(risk_score)

        # Generate summary and recommendations
        summary = self._generate_summary(changes, swift_files)
        recommendations = self._generate_recommendations(changes, risk_level, swift_files)

        return ChangeReport(
            changed_files=[Path(f).name for f in changed_files],
            changes=changes,
            swift_files_affected=sorted(list(swift_files)),
            risk_level=risk_level,
            risk_score=risk_score,
            summary=summary,
            recommendations=recommendations
        )

    def _analyze_file(self, file_path: Path) -> List[TokenChange]:
        """
        Analyze a single SCSS file for changes.

        This is a simplified analysis. In production, you'd:
        - Parse SCSS AST
        - Compare against previous version
        - Detect specific token changes
        """
        changes = []
        file_name = file_path.name

        # Determine change type based on file
        if file_name in ['_light.scss', '_dark.scss']:
            change_type = ChangeType.PRIMITIVE_TOKEN
        elif 'alias' in file_name.lower() or file_name == 'extend.css':
            change_type = ChangeType.ALIAS_TOKEN
        elif file_name.startswith('_') and file_name.endswith('.scss'):
            change_type = ChangeType.COMPONENT_TOKEN
        else:
            change_type = ChangeType.COLOR_VALUE

        # Create change record
        changes.append(TokenChange(
            token_name=f"tokens in {file_name}",
            change_type=change_type,
            old_value=None,  # Would need git diff to determine
            new_value=None,
            file=file_name
        ))

        return changes

    def _calculate_risk_score(self, changes: List[TokenChange], swift_files: Set[str]) -> float:
        """
        Calculate risk score based on changes.

        Risk factors:
        - Type of changes (primitives > aliases > components)
        - Number of changes
        - Number of affected Swift files
        - Breaking changes (removed tokens)
        """
        if not changes:
            return 0.0

        # Base score from change types
        type_score = sum(c.risk_weight for c in changes) / len(changes)

        # File impact factor (0-1)
        total_files = len(self.dependency_graph.get_all_files())
        impact_factor = len(swift_files) / total_files

        # Breaking change multiplier
        breaking_changes = [c for c in changes if c.is_breaking]
        breaking_multiplier = 1.0 + (len(breaking_changes) * 0.5)

        # Final score (0-100)
        risk_score = (type_score * 10) * impact_factor * breaking_multiplier
        return min(risk_score, 100.0)

    def _determine_risk_level(self, risk_score: float) -> RiskLevel:
        """
        Determine risk level from score.

        Thresholds:
        - 0-25: LOW
        - 25-50: MEDIUM
        - 50-75: HIGH
        - 75+: CRITICAL
        """
        if risk_score < 25:
            return RiskLevel.LOW
        elif risk_score < 50:
            return RiskLevel.MEDIUM
        elif risk_score < 75:
            return RiskLevel.HIGH
        else:
            return RiskLevel.CRITICAL

    def _generate_summary(self, changes: List[TokenChange], swift_files: Set[str]) -> str:
        """Generate human-readable summary"""
        num_changes = len(changes)
        num_files = len(swift_files)

        # Categorize changes
        by_type = {}
        for change in changes:
            type_name = change.change_type.value
            by_type[type_name] = by_type.get(type_name, 0) + 1

        summary_parts = [f"{num_changes} change(s) detected affecting {num_files} Swift file(s)"]

        if by_type:
            type_summary = ", ".join([f"{count} {type_name}" for type_name, count in by_type.items()])
            summary_parts.append(f"Changes: {type_summary}")

        return ". ".join(summary_parts)

    def _generate_recommendations(
        self,
        changes: List[TokenChange],
        risk_level: RiskLevel,
        swift_files: Set[str]
    ) -> List[str]:
        """Generate actionable recommendations"""
        recommendations = []

        # Risk-based recommendations
        if risk_level == RiskLevel.LOW:
            recommendations.append("✅ Safe to apply with automated validation")
            recommendations.append("Run selective regeneration with --selective flag")
        elif risk_level == RiskLevel.MEDIUM:
            recommendations.append("⚠️  Review visual regression test results carefully")
            recommendations.append("Run full test suite before committing")
            recommendations.append("Consider manual QA for affected components")
        elif risk_level == RiskLevel.HIGH:
            recommendations.append("⚠️  HIGH RISK: Manual review required")
            recommendations.append("Run visual regression tests and review all diffs")
            recommendations.append("Test affected components manually")
            recommendations.append("Consider staged rollout")
        else:  # CRITICAL
            recommendations.append("🚨 CRITICAL RISK: Do not auto-commit")
            recommendations.append("Full manual review and testing required")
            recommendations.append("Breaking changes detected - update dependent code first")
            recommendations.append("Consider splitting into multiple smaller updates")

        # File-specific recommendations
        if len(swift_files) > 40:
            recommendations.append("Large impact: Primitives or aliases changed - full regeneration needed")
        elif len(swift_files) <= 5:
            recommendations.append(f"Small impact: Only {len(swift_files)} file(s) affected - use selective regeneration")

        # Breaking change recommendations
        breaking_changes = [c for c in changes if c.is_breaking]
        if breaking_changes:
            recommendations.append(f"⚠️  {len(breaking_changes)} breaking change(s) detected")
            recommendations.append("Update code that references removed tokens before applying")

        return recommendations

    def print_report(self, report: ChangeReport, verbose: bool = False):
        """Print formatted change report"""
        print("\n" + "=" * 70)
        print("ELEVATE CHANGE DETECTION REPORT")
        print("=" * 70)
        print()

        # Risk Level
        risk_icons = {
            RiskLevel.LOW: "✅",
            RiskLevel.MEDIUM: "⚠️ ",
            RiskLevel.HIGH: "⚠️ ",
            RiskLevel.CRITICAL: "🚨"
        }
        icon = risk_icons.get(report.risk_level, "")
        print(f"Risk Level: {icon} {report.risk_level.value}")
        print(f"Risk Score: {report.risk_score:.1f}/100")
        print()

        # Summary
        print("Summary:")
        print(f"  {report.summary}")
        print()

        # Changed Files
        print(f"Changed SCSS Files: {len(report.changed_files)}")
        for file in report.changed_files:
            print(f"  • {file}")
        print()

        # Affected Swift Files
        print(f"Affected Swift Files: {len(report.swift_files_affected)}")
        if verbose or len(report.swift_files_affected) <= 10:
            for file in report.swift_files_affected:
                print(f"  → {file}")
        else:
            for file in report.swift_files_affected[:5]:
                print(f"  → {file}")
            print(f"  ... and {len(report.swift_files_affected) - 5} more")
        print()

        # Changes
        if verbose and report.changes:
            print(f"Detailed Changes: {len(report.changes)}")
            for change in report.changes[:10]:  # Show first 10
                print(f"  • {change.change_type.value}: {change.token_name}")
            if len(report.changes) > 10:
                print(f"  ... and {len(report.changes) - 10} more")
            print()

        # Recommendations
        print("Recommendations:")
        for rec in report.recommendations:
            print(f"  {rec}")
        print()

        print("=" * 70)


def main():
    """CLI for ELEVATE change detection"""
    import argparse

    parser = argparse.ArgumentParser(description='Detect ELEVATE design token changes')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    parser.add_argument('--json', action='store_true', help='Output JSON')
    parser.add_argument('--output', '-o', type=str, help='Output file for JSON report')

    args = parser.parse_args()

    detector = ElevateChangeDetector()
    report = detector.detect_changes()

    if args.json:
        output = json.dumps(report.to_dict(), indent=2)
        if args.output:
            with open(args.output, 'w') as f:
                f.write(output)
            print(f"Report saved to {args.output}")
        else:
            print(output)
    else:
        detector.print_report(report, verbose=args.verbose)

    # Exit code based on risk level
    exit_codes = {
        RiskLevel.LOW: 0,
        RiskLevel.MEDIUM: 1,
        RiskLevel.HIGH: 2,
        RiskLevel.CRITICAL: 3
    }
    return exit_codes.get(report.risk_level, 0)


if __name__ == '__main__':
    sys.exit(main())
