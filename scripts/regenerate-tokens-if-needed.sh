#!/bin/bash
#
# ELEVATE Design Token Regeneration Script
# ==========================================
#
# Automatically regenerates design tokens if source files have changed.
# Uses MD5 caching for fast incremental builds.
#
# Usage:
#   ./scripts/regenerate-tokens-if-needed.sh        # Normal build
#   ./scripts/regenerate-tokens-if-needed.sh --force # Force regeneration
#

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Checking if design tokens need regeneration..."

# Check if ELEVATE source path is set
if [ -z "$ELEVATE_TOKENS_PATH" ]; then
    export ELEVATE_TOKENS_PATH="$PROJECT_ROOT/.elevate-src/Elevate-2025-11-04/elevate-design-tokens-main/src/scss"
fi

# Check if ELEVATE source exists
if [ ! -d "$ELEVATE_TOKENS_PATH" ]; then
    echo -e "${YELLOW}⚠️  ELEVATE source not found at: $ELEVATE_TOKENS_PATH${NC}"
    echo "   Skipping token regeneration."
    echo "   To enable automatic regeneration, download ELEVATE source to:"
    echo "   $PROJECT_ROOT/.elevate-src/Elevate-<version>/elevate-design-tokens-main/src/scss"
    exit 0
fi

# Run the Python script (which has built-in caching)
cd "$PROJECT_ROOT"

if [ "$1" == "--force" ]; then
    echo "🔄 Force regenerating design tokens..."
    python3 scripts/update-design-tokens-v4.py --force
else
    python3 scripts/update-design-tokens-v4.py
fi

echo -e "${GREEN}✅ Design token check complete${NC}"
