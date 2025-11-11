#!/bin/bash
#
# Visual Baseline Update Script
# ==============================
#
# Approves and updates visual regression test baselines.
# Use after reviewing snapshot failures in visual-regression-report.html
#
# Usage:
#   ./scripts/update-visual-baselines.sh --all
#   ./scripts/update-visual-baselines.sh --test ButtonVisualTests
#   ./scripts/update-visual-baselines.sh --snapshot Button_primary_default

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SNAPSHOT_DIR="$PROJECT_ROOT/ElevateUITests/__Snapshots__"

# Helper functions
print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  $1"
    echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Count failed snapshots
count_failures() {
    local count=0
    if [ -d "$SNAPSHOT_DIR" ]; then
        count=$(find "$SNAPSHOT_DIR" -name "*.1.png" | wc -l | tr -d ' ')
    fi
    echo "$count"
}

# Update all baselines
update_all_baselines() {
    print_header "Updating All Visual Baselines"

    local failure_count=$(count_failures)

    if [ "$failure_count" -eq "0" ]; then
        print_success "No failed snapshots found!"
        exit 0
    fi

    print_warning "Found $failure_count failed snapshot(s)"
    echo ""

    # List all failures
    print_info "Failed snapshots:"
    find "$SNAPSHOT_DIR" -name "*.1.png" | while read failure_file; do
        local test_class=$(basename "$(dirname "$failure_file")")
        local snapshot_name=$(basename "$failure_file" .1.png)
        echo "   • $test_class / $snapshot_name"
    done

    echo ""
    read -p "❓ Approve ALL changes and update baselines? (y/N): " confirm

    if [ "$confirm" != "y" ]; then
        print_warning "Update cancelled"
        exit 0
    fi

    # Update baselines
    local updated=0
    find "$SNAPSHOT_DIR" -name "*.1.png" | while read failure_file; do
        local baseline_file="${failure_file%.1.png}.png"
        local diff_file="${failure_file%.1.png}.diff.png"

        # Replace baseline with new snapshot
        mv "$failure_file" "$baseline_file"
        print_success "Updated: $(basename "$baseline_file")"

        # Remove diff file
        if [ -f "$diff_file" ]; then
            rm "$diff_file"
        fi

        updated=$((updated + 1))
    done

    echo ""
    print_success "Updated $failure_count baseline(s)"
    echo ""
    print_info "Next steps:"
    echo "   1. Review updated snapshots: git diff $SNAPSHOT_DIR"
    echo "   2. Commit changes: git add $SNAPSHOT_DIR && git commit -m 'Update visual baselines'"
}

# Update baselines for specific test
update_test_baselines() {
    local test_name="$1"

    print_header "Updating Baselines for $test_name"

    local test_dir="$SNAPSHOT_DIR/$test_name"

    if [ ! -d "$test_dir" ]; then
        print_error "Test directory not found: $test_dir"
        exit 1
    fi

    # Count failures in this test
    local failure_count=$(find "$test_dir" -name "*.1.png" | wc -l | tr -d ' ')

    if [ "$failure_count" -eq "0" ]; then
        print_success "No failed snapshots in $test_name"
        exit 0
    fi

    print_info "Found $failure_count failed snapshot(s) in $test_name"
    echo ""

    # List failures
    find "$test_dir" -name "*.1.png" | while read failure_file; do
        local snapshot_name=$(basename "$failure_file" .1.png)
        echo "   • $snapshot_name"
    done

    echo ""
    read -p "❓ Approve changes for $test_name? (y/N): " confirm

    if [ "$confirm" != "y" ]; then
        print_warning "Update cancelled"
        exit 0
    fi

    # Update baselines
    find "$test_dir" -name "*.1.png" | while read failure_file; do
        local baseline_file="${failure_file%.1.png}.png"
        local diff_file="${failure_file%.1.png}.diff.png"

        mv "$failure_file" "$baseline_file"
        print_success "Updated: $(basename "$baseline_file")"

        if [ -f "$diff_file" ]; then
            rm "$diff_file"
        fi
    done

    echo ""
    print_success "Updated $failure_count baseline(s) for $test_name"
}

# Update specific snapshot
update_snapshot_baseline() {
    local snapshot_pattern="$1"

    print_header "Updating Baseline for $snapshot_pattern"

    # Find matching failure files
    local matches=$(find "$SNAPSHOT_DIR" -name "*${snapshot_pattern}*.1.png")

    if [ -z "$matches" ]; then
        print_error "No failed snapshots matching: $snapshot_pattern"
        exit 1
    fi

    # Count matches
    local match_count=$(echo "$matches" | wc -l | tr -d ' ')

    if [ "$match_count" -gt "1" ]; then
        print_warning "Multiple snapshots match '$snapshot_pattern':"
        echo "$matches" | while read match; do
            local test_class=$(basename "$(dirname "$match")")
            local snapshot_name=$(basename "$match" .1.png)
            echo "   • $test_class / $snapshot_name"
        done
        echo ""
        read -p "❓ Update all $match_count matching snapshots? (y/N): " confirm
        if [ "$confirm" != "y" ]; then
            print_warning "Update cancelled"
            exit 0
        fi
    fi

    # Update baselines
    echo "$matches" | while read failure_file; do
        local baseline_file="${failure_file%.1.png}.png"
        local diff_file="${failure_file%.1.png}.diff.png"
        local test_class=$(basename "$(dirname "$failure_file")")
        local snapshot_name=$(basename "$failure_file" .1.png)

        mv "$failure_file" "$baseline_file"
        print_success "Updated: $test_class / $snapshot_name"

        if [ -f "$diff_file" ]; then
            rm "$diff_file"
        fi
    done

    echo ""
    print_success "Baseline(s) updated successfully"
}

# Show status
show_status() {
    print_header "Visual Baseline Status"

    local failure_count=$(count_failures)

    if [ "$failure_count" -eq "0" ]; then
        print_success "No pending baseline updates"
        print_info "All snapshots match current baselines"
        exit 0
    fi

    print_warning "$failure_count pending baseline update(s)"
    echo ""

    print_info "Failed snapshots by test:"
    find "$SNAPSHOT_DIR" -type d -mindepth 1 -maxdepth 1 | sort | while read test_dir; do
        local test_name=$(basename "$test_dir")
        local test_failures=$(find "$test_dir" -name "*.1.png" | wc -l | tr -d ' ')
        if [ "$test_failures" -gt "0" ]; then
            echo "   • $test_name: $test_failures failure(s)"
        fi
    done

    echo ""
    print_info "Commands:"
    echo "   Update all:         ./scripts/update-visual-baselines.sh --all"
    echo "   Update test:        ./scripts/update-visual-baselines.sh --test ButtonVisualTests"
    echo "   Update snapshot:    ./scripts/update-visual-baselines.sh --snapshot Button_primary"
    echo "   View report:        open visual-regression-report.html"
}

# Show help
show_help() {
    cat <<EOF
Visual Baseline Update Script
==============================

Update visual regression test baselines after reviewing failures.

USAGE:
    ./scripts/update-visual-baselines.sh [OPTIONS]

OPTIONS:
    --all                   Update all failed baselines
    --test <TestClass>      Update baselines for specific test class
    --snapshot <Pattern>    Update baseline(s) matching snapshot name
    --status                Show current status
    --help                  Show this help message

EXAMPLES:
    # Show status
    ./scripts/update-visual-baselines.sh --status

    # Update all baselines
    ./scripts/update-visual-baselines.sh --all

    # Update specific test
    ./scripts/update-visual-baselines.sh --test ButtonVisualTests

    # Update specific snapshot
    ./scripts/update-visual-baselines.sh --snapshot Button_primary_default

WORKFLOW:
    1. Run tests: xcodebuild test -scheme ElevateUI
    2. Generate report: python3 scripts/visual-diff-report.py
    3. Review report: open visual-regression-report.html
    4. Approve changes: ./scripts/update-visual-baselines.sh --all
    5. Commit: git add __Snapshots__ && git commit -m "Update visual baselines"

BASELINE LOCATIONS:
    Test snapshots are stored in:
    ElevateUITests/__Snapshots__/{TestClass}/{snapshot_name}.png

    Failed snapshots create:
    - {snapshot_name}.1.png     (new snapshot)
    - {snapshot_name}.diff.png  (visual diff)
EOF
}

# Main command dispatcher
main() {
    case "${1:-help}" in
        --all)
            update_all_baselines
            ;;
        --test)
            if [ -z "$2" ]; then
                print_error "Test name required: --test ButtonVisualTests"
                exit 1
            fi
            update_test_baselines "$2"
            ;;
        --snapshot)
            if [ -z "$2" ]; then
                print_error "Snapshot pattern required: --snapshot Button_primary"
                exit 1
            fi
            update_snapshot_baseline "$2"
            ;;
        --status)
            show_status
            ;;
        --help|-h|help)
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"
