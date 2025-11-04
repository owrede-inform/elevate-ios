#!/bin/bash

################################################################################
# ELEVATE UI Complete Update Script
################################################################################
#
# This script automates the entire ELEVATE UI update workflow:
# 1. Fetches latest ELEVATE Core UI design tokens from GitHub
# 2. Regenerates all Swift token files (Primitives, Aliases, Components)
# 3. Builds the ElevateUI package
# 4. Runs all tests
# 5. Reports success or failures with actionable errors
#
# Usage:
#   ./scripts/update-elevate-ui.sh [--remote] [--skip-tests]
#
# Options:
#   --remote      Fetch tokens from GitHub instead of local clone
#   --skip-tests  Skip running tests (faster, but not recommended)
#   --force       Force update even if no changes detected
#   --help        Show this help message
#
################################################################################

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Configuration
ELEVATE_TOKENS_REPO="https://github.com/inform-elevate/elevate-design-tokens.git"
ELEVATE_TOKENS_BRANCH="main"
TEMP_TOKENS_DIR="/tmp/elevate-tokens-$(date +%s)"
CACHE_FILE="$PROJECT_ROOT/.elevate-token-cache.json"
TOKEN_SCRIPT="$SCRIPT_DIR/update-design-tokens-v3.py"

# Parse command line arguments
USE_REMOTE=false
SKIP_TESTS=false
FORCE_UPDATE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --remote)
            USE_REMOTE=true
            shift
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --force)
            FORCE_UPDATE=true
            shift
            ;;
        --help)
            head -n 30 "$0" | grep "^#" | sed 's/^# //' | sed 's/^#//'
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

################################################################################
# Helper Functions
################################################################################

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_step() {
    echo ""
    echo -e "${CYAN}▶ $1${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

compute_hash() {
    local content="$1"
    echo -n "$content" | shasum -a 256 | cut -d' ' -f1
}

check_dependencies() {
    local missing_deps=()

    if ! command -v python3 &> /dev/null; then
        missing_deps+=("python3")
    fi

    if ! command -v swift &> /dev/null; then
        missing_deps+=("swift")
    fi

    if ! command -v git &> /dev/null && [ "$USE_REMOTE" = true ]; then
        missing_deps+=("git")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

################################################################################
# Step 1: Fetch ELEVATE Tokens
################################################################################

fetch_tokens() {
    log_step "Step 1: Fetching ELEVATE Design Tokens"

    if [ "$USE_REMOTE" = true ]; then
        log_info "Fetching tokens from GitHub (remote mode)..."

        # Clone to temporary directory
        if [ -d "$TEMP_TOKENS_DIR" ]; then
            rm -rf "$TEMP_TOKENS_DIR"
        fi

        log_info "Cloning repository to $TEMP_TOKENS_DIR..."
        git clone --depth 1 --branch "$ELEVATE_TOKENS_BRANCH" "$ELEVATE_TOKENS_REPO" "$TEMP_TOKENS_DIR" 2>&1 | sed 's/^/  /'

        if [ ! -d "$TEMP_TOKENS_DIR/src/scss" ]; then
            log_error "Token repository structure unexpected - src/scss not found"
            exit 1
        fi

        export ELEVATE_TOKENS_PATH="$TEMP_TOKENS_DIR/src/scss"
        log_success "Tokens fetched from GitHub"

    else
        log_info "Using local ELEVATE tokens..."

        # Check if ELEVATE_TOKENS_PATH is set
        if [ -z "${ELEVATE_TOKENS_PATH:-}" ]; then
            log_error "ELEVATE_TOKENS_PATH not set and --remote not specified"
            log_info "Either:"
            log_info "  1. Set ELEVATE_TOKENS_PATH environment variable, or"
            log_info "  2. Use --remote flag to fetch from GitHub"
            exit 1
        fi

        if [ ! -d "$ELEVATE_TOKENS_PATH" ]; then
            log_error "ELEVATE_TOKENS_PATH directory not found: $ELEVATE_TOKENS_PATH"
            exit 1
        fi

        log_success "Using local tokens at $ELEVATE_TOKENS_PATH"
    fi
}

################################################################################
# Step 2: Check if Update Needed
################################################################################

check_if_update_needed() {
    log_step "Step 2: Checking if Update Needed"

    if [ "$FORCE_UPDATE" = true ]; then
        log_info "Force update enabled - skipping change detection"
        return 0
    fi

    local light_file="$ELEVATE_TOKENS_PATH/values/_light.scss"
    local dark_file="$ELEVATE_TOKENS_PATH/values/_dark.scss"

    if [ ! -f "$light_file" ] || [ ! -f "$dark_file" ]; then
        log_error "Token files not found in expected location"
        exit 1
    fi

    # Compute hash of current tokens
    local current_hash
    current_hash=$(compute_hash "$(cat "$light_file" "$dark_file")")

    log_info "Current token hash: ${current_hash:0:12}..."

    # Check cache
    if [ -f "$CACHE_FILE" ]; then
        local cached_hash
        cached_hash=$(python3 -c "import json; print(json.load(open('$CACHE_FILE')).get('hash', ''))" 2>/dev/null || echo "")

        if [ "$cached_hash" = "$current_hash" ]; then
            log_success "No changes detected - tokens are up to date"
            log_info "Use --force to regenerate anyway"
            return 1
        else
            log_info "Changes detected (cached: ${cached_hash:0:12}...)"
        fi
    else
        log_info "No cache file found - will generate tokens"
    fi

    return 0
}

################################################################################
# Step 3: Regenerate Token Files
################################################################################

regenerate_tokens() {
    log_step "Step 3: Regenerating Swift Token Files"

    cd "$PROJECT_ROOT"

    log_info "Running token extraction script..."
    python3 "$TOKEN_SCRIPT" 2>&1 | sed 's/^/  /'

    local exit_code=${PIPESTATUS[0]}

    if [ $exit_code -ne 0 ]; then
        log_error "Token generation failed with exit code $exit_code"
        exit 1
    fi

    log_success "Token files regenerated successfully"

    # Count tokens
    local token_count
    token_count=$(find ElevateUI/Sources/DesignTokens/Generated -name "*.swift" -exec grep -c "public static let" {} + | awk '{s+=$1} END {print s}')
    log_info "Generated $token_count tokens across 5 files"
}

################################################################################
# Step 4: Build Package
################################################################################

build_package() {
    log_step "Step 4: Building ElevateUI Package"

    cd "$PROJECT_ROOT"

    log_info "Running swift build..."

    # Build and capture output
    if swift build 2>&1 | tee /tmp/elevate-build-output.txt | sed 's/^/  /'; then
        log_success "Build succeeded"

        # Show build time
        local build_time
        build_time=$(grep -o "Build complete! ([^)]*)" /tmp/elevate-build-output.txt | sed 's/Build complete! (//' | sed 's/)//')
        log_info "Build time: $build_time"

        return 0
    else
        log_error "Build failed"
        log_info "Check output above for error details"

        # Try to provide helpful error messages
        if grep -q "Cannot find type 'DynamicColor'" /tmp/elevate-build-output.txt; then
            log_warning "Found references to old DynamicColor - may need manual migration"
        fi

        if grep -q "has no member" /tmp/elevate-build-output.txt; then
            log_warning "Found missing token members - ELEVATE tokens may have changed"
        fi

        return 1
    fi
}

################################################################################
# Step 5: Run Tests
################################################################################

run_tests() {
    if [ "$SKIP_TESTS" = true ]; then
        log_step "Step 5: Tests (Skipped)"
        log_warning "Tests skipped per --skip-tests flag"
        return 0
    fi

    log_step "Step 5: Running Tests"

    cd "$PROJECT_ROOT"

    log_info "Running swift test..."

    # Run tests and capture output
    if swift test 2>&1 | tee /tmp/elevate-test-output.txt | sed 's/^/  /'; then
        log_success "All tests passed"

        # Count tests
        local test_count
        test_count=$(grep -c "Test Case.*passed" /tmp/elevate-test-output.txt || echo "0")
        log_info "Tests passed: $test_count"

        return 0
    else
        log_error "Tests failed"
        log_info "Check output above for failure details"
        return 1
    fi
}

################################################################################
# Step 6: Update Cache
################################################################################

update_cache() {
    log_step "Step 6: Updating Cache"

    local light_file="$ELEVATE_TOKENS_PATH/values/_light.scss"
    local dark_file="$ELEVATE_TOKENS_PATH/values/_dark.scss"
    local current_hash
    current_hash=$(compute_hash "$(cat "$light_file" "$dark_file")")

    # Create cache file
    cat > "$CACHE_FILE" <<EOF
{
  "hash": "$current_hash",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "elevate_version": "latest",
  "script_version": "v3.2"
}
EOF

    log_success "Cache updated"
    log_info "Hash: ${current_hash:0:12}..."
}

################################################################################
# Cleanup
################################################################################

cleanup() {
    if [ "$USE_REMOTE" = true ] && [ -d "$TEMP_TOKENS_DIR" ]; then
        log_info "Cleaning up temporary files..."
        rm -rf "$TEMP_TOKENS_DIR"
    fi
}

################################################################################
# Main Execution
################################################################################

main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║         ELEVATE UI Complete Update Script v1.0             ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""

    # Check dependencies
    check_dependencies

    # Start timer
    local start_time
    start_time=$(date +%s)

    # Execute workflow
    fetch_tokens

    if check_if_update_needed; then
        regenerate_tokens

        if build_package; then
            if run_tests; then
                update_cache

                echo ""
                echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
                echo -e "${GREEN}║                  ✓ UPDATE SUCCESSFUL                       ║${NC}"
                echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
                echo ""
                log_success "ElevateUI updated successfully"

                # Calculate elapsed time
                local end_time
                end_time=$(date +%s)
                local elapsed=$((end_time - start_time))
                log_info "Total time: ${elapsed}s"

                cleanup
                exit 0
            else
                log_error "Tests failed - update incomplete"
                cleanup
                exit 1
            fi
        else
            log_error "Build failed - update incomplete"
            cleanup
            exit 1
        fi
    else
        log_info "No update needed - skipping build and tests"
        cleanup
        exit 0
    fi
}

# Trap errors and cleanup
trap cleanup EXIT ERR INT TERM

# Run main function
main "$@"
