#!/usr/bin/env python3
"""
Visual Regression Diff Reporter
================================

Generates HTML reports for visual regression test failures.
Analyzes snapshot test failures and creates side-by-side comparisons.

Usage:
    python3 scripts/visual-diff-report.py
    python3 scripts/visual-diff-report.py --output custom-report.html
    python3 scripts/visual-diff-report.py --snapshot-dir path/to/snapshots

The script looks for snapshot failures in the test output and generates
an HTML report with before/after/diff visualizations.
"""

import os
import sys
import re
import json
from pathlib import Path
from typing import List, Dict, Optional
from datetime import datetime

# Paths
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
SNAPSHOT_DIR = PROJECT_ROOT / "ElevateUITests" / "__Snapshots__"
DEFAULT_OUTPUT = PROJECT_ROOT / "visual-regression-report.html"


class SnapshotFailure:
    """Represents a failed snapshot comparison"""

    def __init__(self, test_name: str, snapshot_name: str, baseline_path: str, failure_path: str, diff_path: Optional[str] = None):
        self.test_name = test_name
        self.snapshot_name = snapshot_name
        self.baseline_path = baseline_path
        self.failure_path = failure_path
        self.diff_path = diff_path
        self.change_percent = 0.0

    def __repr__(self):
        return f"SnapshotFailure({self.test_name}/{self.snapshot_name})"


class VisualDiffReporter:
    """Generates visual diff reports from snapshot test failures"""

    def __init__(self, snapshot_dir: Path = SNAPSHOT_DIR):
        self.snapshot_dir = snapshot_dir
        self.failures: List[SnapshotFailure] = []

    def find_snapshot_failures(self) -> List[SnapshotFailure]:
        """
        Find all snapshot test failures by looking for new/diff images

        swift-snapshot-testing generates:
        - {name}.png - baseline
        - {name}.1.png - failed snapshot
        - {name}.diff.png - visual diff
        """
        failures = []

        if not self.snapshot_dir.exists():
            print(f"⚠️  Snapshot directory not found: {self.snapshot_dir}")
            return failures

        # Find all .1.png files (failed snapshots)
        for failure_file in self.snapshot_dir.rglob("*.1.png"):
            # Extract test class and snapshot name
            test_class = failure_file.parent.name
            snapshot_name = failure_file.stem.replace(".1", "")

            # Find corresponding baseline and diff
            baseline_file = failure_file.parent / f"{snapshot_name}.png"
            diff_file = failure_file.parent / f"{snapshot_name}.diff.png"

            failure = SnapshotFailure(
                test_name=test_class,
                snapshot_name=snapshot_name,
                baseline_path=str(baseline_file.relative_to(PROJECT_ROOT)),
                failure_path=str(failure_file.relative_to(PROJECT_ROOT)),
                diff_path=str(diff_file.relative_to(PROJECT_ROOT)) if diff_file.exists() else None
            )

            failures.append(failure)

        return failures

    def generate_html_report(self, output_file: Path = DEFAULT_OUTPUT) -> None:
        """Generate HTML report with side-by-side comparisons"""

        self.failures = self.find_snapshot_failures()

        if not self.failures:
            print("✅ No snapshot failures found!")
            return

        print(f"📊 Found {len(self.failures)} snapshot failures")

        html = self._generate_html()

        with open(output_file, 'w') as f:
            f.write(html)

        print(f"📝 Report generated: {output_file}")
        print(f"🌐 Open in browser: open {output_file}")

    def _generate_html(self) -> str:
        """Generate HTML content"""

        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visual Regression Report - {timestamp}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: #f5f5f7;
            color: #1d1d1f;
            padding: 20px;
            line-height: 1.6;
        }}

        .container {{
            max-width: 1400px;
            margin: 0 auto;
        }}

        header {{
            background: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }}

        h1 {{
            font-size: 32px;
            font-weight: 700;
            color: #1d1d1f;
            margin-bottom: 10px;
        }}

        .summary {{
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }}

        .summary-item {{
            background: #f5f5f7;
            padding: 15px 20px;
            border-radius: 8px;
            flex: 1;
        }}

        .summary-label {{
            font-size: 12px;
            color: #6e6e73;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
        }}

        .summary-value {{
            font-size: 28px;
            font-weight: 700;
            color: #d32f2f;
            margin-top: 5px;
        }}

        .failure {{
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }}

        .failure-header {{
            border-bottom: 2px solid #f5f5f7;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }}

        .failure-title {{
            font-size: 20px;
            font-weight: 600;
            color: #1d1d1f;
            margin-bottom: 5px;
        }}

        .failure-path {{
            font-size: 14px;
            color: #6e6e73;
            font-family: "SF Mono", Monaco, "Courier New", monospace;
        }}

        .comparison {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }}

        .image-container {{
            background: #f5f5f7;
            border-radius: 8px;
            padding: 15px;
        }}

        .image-label {{
            font-size: 13px;
            font-weight: 600;
            color: #6e6e73;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }}

        .image-container img {{
            width: 100%;
            height: auto;
            border-radius: 6px;
            border: 1px solid #e5e5ea;
            background: white;
            display: block;
        }}

        .diff-image {{
            background: #fff3e0;
        }}

        .actions {{
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }}

        .btn {{
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }}

        .btn-primary {{
            background: #007aff;
            color: white;
        }}

        .btn-primary:hover {{
            background: #0051d5;
        }}

        .btn-secondary {{
            background: #f5f5f7;
            color: #1d1d1f;
        }}

        .btn-secondary:hover {{
            background: #e5e5ea;
        }}

        footer {{
            text-align: center;
            margin-top: 40px;
            color: #6e6e73;
            font-size: 14px;
        }}

        .badge {{
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }}

        .badge-error {{
            background: #ffebee;
            color: #d32f2f;
        }}

        .badge-warning {{
            background: #fff3e0;
            color: #f57c00;
        }}

        @media (max-width: 768px) {{
            .comparison {{
                grid-template-columns: 1fr;
            }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📸 Visual Regression Report</h1>
            <p>Generated: {timestamp}</p>

            <div class="summary">
                <div class="summary-item">
                    <div class="summary-label">Total Failures</div>
                    <div class="summary-value">{len(self.failures)}</div>
                </div>
                <div class="summary-item">
                    <div class="summary-label">Status</div>
                    <div class="summary-value" style="color: #d32f2f;">FAILED</div>
                </div>
            </div>
        </header>

        <main>
"""

        # Add each failure
        for i, failure in enumerate(self.failures, 1):
            html += self._generate_failure_html(failure, i)

        html += """
        </main>

        <footer>
            <p><strong>ELEVATE iOS</strong> - Visual Regression Testing</p>
            <p>Generated by scripts/visual-diff-report.py</p>
        </footer>
    </div>
</body>
</html>
"""

        return html

    def _generate_failure_html(self, failure: SnapshotFailure, index: int) -> str:
        """Generate HTML for a single failure"""

        return f"""
            <div class="failure">
                <div class="failure-header">
                    <div class="failure-title">
                        {index}. {failure.test_name}
                        <span class="badge badge-error">FAILED</span>
                    </div>
                    <div class="failure-path">{failure.snapshot_name}</div>
                </div>

                <div class="comparison">
                    <div class="image-container">
                        <div class="image-label">✅ Expected (Baseline)</div>
                        <img src="{failure.baseline_path}" alt="Baseline">
                    </div>

                    <div class="image-container">
                        <div class="image-label">❌ Actual (Current)</div>
                        <img src="{failure.failure_path}" alt="Current">
                    </div>

                    {f'''
                    <div class="image-container diff-image">
                        <div class="image-label">🔍 Difference</div>
                        <img src="{failure.diff_path}" alt="Diff">
                    </div>
                    ''' if failure.diff_path else ''}
                </div>

                <div class="actions">
                    <button class="btn btn-primary" onclick="alert('Run: scripts/update-visual-baselines.sh --approve {failure.test_name}')">
                        Approve Change
                    </button>
                    <button class="btn btn-secondary" onclick="alert('Baseline: {failure.baseline_path}')">
                        View Details
                    </button>
                </div>
            </div>
"""


def main():
    import argparse

    parser = argparse.ArgumentParser(description='Generate visual regression diff report')
    parser.add_argument('--output', default=str(DEFAULT_OUTPUT), help='Output HTML file')
    parser.add_argument('--snapshot-dir', default=str(SNAPSHOT_DIR), help='Snapshot directory')

    args = parser.parse_args()

    reporter = VisualDiffReporter(snapshot_dir=Path(args.snapshot_dir))
    reporter.generate_html_report(output_file=Path(args.output))


if __name__ == '__main__':
    main()
