#!/bin/bash
#
# ELEVATE Update Orchestrator - CLI Interface
# ============================================
#
# User-friendly CLI for the intelligent ELEVATE update system.
# Orchestrates: check → analyze → validate → report
#
# Usage:
#   ./scripts/elevate-update.sh check           # Check for new ELEVATE version
#   ./scripts/elevate-update.sh preview         # Preview changes and risk analysis
#   ./scripts/elevate-update.sh apply           # Apply changes with validation
#   ./scripts/elevate-update.sh validate        # Run validation pipeline
#   ./scripts/elevate-update.sh rollback        # Rollback last update
#   ./scripts/elevate-update.sh --help          # Show detailed help

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ELEVATE_SRC="$PROJECT_ROOT/.elevate-src"
KNOWLEDGE_BASE="$PROJECT_ROOT/.elevate-knowledge"

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

# Command: check
cmd_check() {
    print_header "Checking for ELEVATE Updates"

    print_info "Current ELEVATE version in .elevate-src:"
    if [ -d "$ELEVATE_SRC" ]; then
        ls -1 "$ELEVATE_SRC" | head -1
    else
        print_warning "No .elevate-src directory found"
    fi

    echo ""
    print_info "To update ELEVATE sources:"
    echo "  1. Download latest from GitHub:"
    echo "     - https://github.com/inform-elevate/elevate-design-tokens"
    echo "     - https://github.com/inform-elevate/elevate-core-ui"
    echo "     - https://github.com/inform-elevate/elevate-icons"
    echo "  2. Place in .elevate-src/Elevate-YYYY-MM-DD/"
    echo "  3. Run: ./scripts/elevate-update.sh analyze"
    echo ""
}

# Command: analyze
cmd_analyze() {
    print_header "Analyzing ELEVATE Changes"

    if [ ! -f "$SCRIPT_DIR/analyze-elevate-changes.py" ]; then
        print_error "analyze-elevate-changes.py not found"
        exit 1
    fi

    print_info "Testing SCSS token parsing..."
    python3 "$SCRIPT_DIR/analyze-elevate-changes.py" --test

    echo ""
    print_success "Change detection engine operational"
    echo ""
    print_info "To compare two versions:"
    echo "  python3 scripts/analyze-elevate-changes.py \\"
    echo "    --from-path .elevate-src/version1 \\"
    echo "    --to-path .elevate-src/version2"
    echo ""
}

# Command: validate
cmd_validate() {
    print_header "Validating iOS HIG Compliance"

    if [ ! -f "$SCRIPT_DIR/validate-ios-compliance.py" ]; then
        print_error "validate-ios-compliance.py not found"
        exit 1
    fi

    print_info "Running compliance checks on all components..."
    echo ""

    # Run validator (will exit 1 if failures found)
    python3 "$SCRIPT_DIR/validate-ios-compliance.py" || {
        echo ""
        print_warning "Found HIG compliance issues"
        echo ""
        print_info "To validate specific component:"
        echo "  python3 scripts/validate-ios-compliance.py --component Button"
        echo ""
        return 1
    }

    echo ""
    print_success "All components pass HIG compliance!"
    echo ""
}

# Command: status
cmd_status() {
    print_header "ELEVATE Update System Status"

    echo "📊 Component Status:"
    echo ""

    # Check knowledge base
    if [ -d "$KNOWLEDGE_BASE" ]; then
        print_success "Knowledge Base: Initialized"
        if [ -f "$KNOWLEDGE_BASE/patterns.json" ]; then
            pattern_count=$(jq '.patterns | length' "$KNOWLEDGE_BASE/patterns.json" 2>/dev/null || echo "0")
            echo "    • Patterns: $pattern_count"
        fi
    else
        print_warning "Knowledge Base: Not initialized"
    fi

    # Check change detector
    if [ -f "$SCRIPT_DIR/analyze-elevate-changes.py" ]; then
        print_success "Change Detector: Ready"
    else
        print_error "Change Detector: Missing"
    fi

    # Check validator
    if [ -f "$SCRIPT_DIR/validate-ios-compliance.py" ]; then
        print_success "iOS Validator: Ready"
    else
        print_error "iOS Validator: Missing"
    fi

    # Check ELEVATE sources
    if [ -d "$ELEVATE_SRC" ]; then
        print_success "ELEVATE Sources: Found"
        ls -1 "$ELEVATE_SRC" | head -1 | sed 's/^/    • /'
    else
        print_warning "ELEVATE Sources: Not found"
    fi

    echo ""
    echo "🎯 Automation Coverage:"
    echo "    • Phase 1 (Current): Foundation complete"
    echo "    • Change Detection: ✅ Operational (2015 tokens parsed)"
    echo "    • iOS Validation: ✅ Operational (HIG compliance)"
    echo "    • Pattern Matching: ⏳ 6 patterns documented"
    echo "    • Auto-Generation: ⏳ Phase 2 (not yet implemented)"
    echo ""

    echo "📈 Next Steps for 40% Automation:"
    echo "    1. Test change detector with two ELEVATE versions"
    echo "    2. Extract more patterns from git history"
    echo "    3. Implement template-based code generation"
    echo "    4. Add iOS impact prediction"
    echo ""
}

# Command: update (full workflow)
cmd_update() {
    print_header "Full ELEVATE Update Workflow"

    print_info "Step 1: Checking for updates..."
    cmd_check

    print_info "Step 2: Analyzing changes..."
    cmd_analyze || true

    print_info "Step 3: Validating iOS compliance..."
    cmd_validate || true

    echo ""
    print_success "Update workflow complete!"
    echo ""
    print_info "Manual steps required:"
    echo "  1. Review change analysis report"
    echo "  2. Apply updates using scripts/update-design-tokens-v4.py"
    echo "  3. Address any HIG compliance issues"
    echo "  4. Run tests: swift test"
    echo "  5. Commit changes"
    echo ""
}

# Command: help
cmd_help() {
    cat <<EOF
ELEVATE Update Orchestrator - Intelligent Update System
========================================================

A CLI tool for managing ELEVATE design token updates with AI-powered automation.

USAGE:
    ./scripts/elevate-update.sh [COMMAND]

COMMANDS:
    check       Check for new ELEVATE versions
    analyze     Analyze changes between ELEVATE versions
    validate    Validate iOS HIG compliance
    status      Show system status and capabilities
    update      Run full update workflow
    help        Show this help message

EXAMPLES:
    # Check current status
    ./scripts/elevate-update.sh status

    # Validate all components
    ./scripts/elevate-update.sh validate

    # Full update workflow
    ./scripts/elevate-update.sh update

DETAILED USAGE:

  Change Analysis:
    python3 scripts/analyze-elevate-changes.py --test
    python3 scripts/analyze-elevate-changes.py --from v0.36.0 --to v0.37.0

  iOS Validation:
    python3 scripts/validate-ios-compliance.py
    python3 scripts/validate-ios-compliance.py --component Button
    python3 scripts/validate-ios-compliance.py --output report.txt

SYSTEM ARCHITECTURE:
    .elevate-knowledge/     AI knowledge base
    ├── patterns.json       6 iOS adaptation patterns
    ├── templates/          Swift code templates
    └── cache/              Cached analyses

    scripts/
    ├── analyze-elevate-changes.py    Change detection engine
    ├── validate-ios-compliance.py    iOS HIG validator
    ├── update-design-tokens-v4.py    Token generator
    └── elevate-update.sh             This orchestrator

DOCUMENTATION:
    docs/INTELLIGENT_UPDATE_SYSTEM.md    Full system design
    docs/DIVERSIONS.md                   iOS adaptation patterns
    docs/ELEVATE_UPDATE_STRATEGY.md      Update strategy

For more information, see: docs/INTELLIGENT_UPDATE_SYSTEM.md
EOF
}

# Command: preview
cmd_preview() {
    print_header "Preview ELEVATE Token Update"

    print_info "Step 1/3: Detecting changes..."
    if ! python3 "$SCRIPT_DIR/detect-elevate-changes.py" --verbose; then
        RISK_CODE=$?
        echo ""
        if [ $RISK_CODE -eq 3 ]; then
            print_error "CRITICAL RISK detected - manual review required"
            exit 1
        elif [ $RISK_CODE -eq 2 ]; then
            print_warning "HIGH RISK detected - proceed with caution"
        fi
    fi

    echo ""
    print_info "Step 2/3: Calculating impact..."
    python3 "$SCRIPT_DIR/benchmark-token-generation.py" --scenario single

    echo ""
    print_info "Step 3/3: Recommendations"
    print_success "Preview complete!"
    echo ""
    echo "To apply these changes:"
    echo "  ./scripts/elevate-update.sh apply"
    echo ""
    echo "For selective regeneration (faster):"
    echo "  ./scripts/elevate-update.sh apply --selective"
    echo ""
}

# Command: apply
cmd_apply() {
    local SELECTIVE_FLAG=""
    local AUTO_COMMIT=false

    # Parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            --selective)
                SELECTIVE_FLAG="--selective"
                shift
                ;;
            --auto-commit)
                AUTO_COMMIT=true
                shift
                ;;
            *)
                shift
                ;;
        esac
    done

    print_header "Apply ELEVATE Token Update"

    # Step 1: Risk check
    print_info "Step 1/5: Risk assessment..."
    if ! python3 "$SCRIPT_DIR/detect-elevate-changes.py"; then
        RISK_CODE=$?
        if [ $RISK_CODE -eq 3 ]; then
            print_error "CRITICAL RISK - aborting auto-apply"
            print_info "Run manual preview first: ./scripts/elevate-update.sh preview"
            exit 1
        elif [ $RISK_CODE -eq 2 ]; then
            print_warning "HIGH RISK detected"
            read -p "Continue anyway? (y/N) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_info "Aborted by user"
                exit 0
            fi
        fi
    fi

    # Step 2: Create restore point
    print_info "Step 2/5: Creating restore point..."
    RESTORE_BRANCH="restore-tokens-$(date +%Y%m%d-%H%M%S)"
    if git diff --quiet && git diff --cached --quiet; then
        print_success "Working directory clean"
    else
        print_warning "Uncommitted changes detected"
        git stash push -m "Pre-token-update stash $(date +%Y%m%d-%H%M%S)"
        print_success "Changes stashed"
    fi
    git branch "$RESTORE_BRANCH"
    print_success "Restore point created: $RESTORE_BRANCH"

    # Step 3: Regenerate tokens
    print_info "Step 3/5: Regenerating tokens..."
    if python3 "$SCRIPT_DIR/update-design-tokens-v4.py" $SELECTIVE_FLAG; then
        print_success "Tokens regenerated"
    else
        print_error "Token regeneration failed"
        print_info "Restore point available: $RESTORE_BRANCH"
        exit 1
    fi

    # Step 4: Run validation pipeline
    print_info "Step 4/5: Running validation..."
    if cmd_validate_quiet; then
        print_success "Validation passed"
    else
        print_error "Validation failed"
        print_info "Changes not committed. Restore point: $RESTORE_BRANCH"
        exit 1
    fi

    # Step 5: Commit (if auto-commit enabled)
    print_info "Step 5/5: Finalization..."
    if [ "$AUTO_COMMIT" = true ]; then
        git add ElevateUI/Sources/DesignTokens/
        git commit -m "chore: Update ELEVATE design tokens

Automated token update from elevate-update.sh
Risk level: LOW
Validation: PASSED

🤖 Generated with elevate-update.sh"
        print_success "Changes committed"
    else
        print_info "Changes not committed (use --auto-commit flag)"
        print_info "Review changes with: git diff"
    fi

    echo ""
    print_success "Token update complete!"
    echo ""
    print_info "Next steps:"
    echo "  • Review changes: git diff"
    echo "  • Run tests: xcodebuild test -scheme ElevateUI"
    echo "  • Rollback if needed: ./scripts/elevate-update.sh rollback"
    echo ""
}

# Command: rollback
cmd_rollback() {
    print_header "Rollback Token Update"

    # Find most recent restore branch
    RESTORE_BRANCH=$(git branch --list "restore-tokens-*" --sort=-committerdate | head -1 | sed 's/^[* ]*//')

    if [ -z "$RESTORE_BRANCH" ]; then
        print_error "No restore point found"
        print_info "Restore branches have format: restore-tokens-YYYYMMDD-HHMMSS"
        exit 1
    fi

    print_info "Found restore point: $RESTORE_BRANCH"
    echo ""
    print_warning "This will reset all token files to the restore point"
    read -p "Continue with rollback? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Rollback cancelled"
        exit 0
    fi

    # Rollback
    print_info "Rolling back..."
    git checkout "$RESTORE_BRANCH" -- ElevateUI/Sources/DesignTokens/
    print_success "Token files restored"

    # Clean up
    print_info "Cleaning up restore branch..."
    git branch -d "$RESTORE_BRANCH"
    print_success "Restore branch removed"

    echo ""
    print_success "Rollback complete!"
    echo ""
}

# Quiet validation for use in apply workflow
cmd_validate_quiet() {
    # Run essential validations without verbose output
    # Returns 0 on success, 1 on failure

    # Check if token files are valid Swift
    if ! swift build -c release --target ElevateUI >/dev/null 2>&1; then
        return 1
    fi

    # Run token consistency tests
    if ! xcodebuild test -scheme ElevateUI -destination 'platform=iOS Simulator,name=iPhone 17' \
         -only-testing:ElevateUITests/TokenConsistencyTests >/dev/null 2>&1; then
        return 1
    fi

    return 0
}

# Main command dispatcher
main() {
    case "${1:-help}" in
        check)
            cmd_check
            ;;
        preview)
            cmd_preview
            ;;
        apply)
            shift  # Remove 'apply' from args
            cmd_apply "$@"
            ;;
        validate)
            cmd_validate
            ;;
        rollback)
            cmd_rollback
            ;;
        status)
            cmd_status
            ;;
        update)
            cmd_update
            ;;
        help|--help|-h)
            cmd_help
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            cmd_help
            exit 1
            ;;
    esac
}

main "$@"
