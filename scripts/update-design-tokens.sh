#!/bin/bash

# ELEVATE Design Tokens Update Script
# Extracts design tokens from ELEVATE source and generates iOS Swift code

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ELEVATE_TOKENS_SRC="/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss"
OUTPUT_DIR="$PROJECT_ROOT/ElevateUI/Sources/DesignTokens"

echo "🎨 ELEVATE Design Tokens Update Script"
echo "========================================"
echo ""
echo "Source: $ELEVATE_TOKENS_SRC"
echo "Output: $OUTPUT_DIR"
echo ""

# Check if source exists
if [ ! -d "$ELEVATE_TOKENS_SRC" ]; then
    echo "❌ Error: ELEVATE design tokens source not found at $ELEVATE_TOKENS_SRC"
    exit 1
fi

# Create scripts directory if it doesn't exist
mkdir -p "$SCRIPT_DIR/lib"

# Source the parser libraries
source "$SCRIPT_DIR/lib/scss-parser.sh"
source "$SCRIPT_DIR/lib/swift-generator.sh"

echo "📝 Step 1: Extracting design tokens from SCSS files..."
echo ""

# Extract button tokens
echo "  → Extracting button tokens..."
BUTTON_TOKENS=$(extract_button_tokens "$ELEVATE_TOKENS_SRC/tokens/component/_button.scss")

# Extract spacing tokens
echo "  → Extracting spacing tokens..."
SPACING_TOKENS=$(extract_spacing_tokens "$ELEVATE_TOKENS_SRC/tokens/_measures.scss")

# Extract color tokens from alias files
echo "  → Extracting color tokens..."
COLOR_TOKENS=$(extract_color_tokens "$ELEVATE_TOKENS_SRC/tokens/alias/_action.scss")

echo ""
echo "✅ Token extraction complete"
echo ""

echo "🔨 Step 2: Generating Swift code..."
echo ""

# Generate ButtonTokens.swift
echo "  → Generating ButtonTokens.swift..."
generate_button_tokens_swift "$BUTTON_TOKENS" > "$OUTPUT_DIR/Components/ButtonTokens.swift.new"

# Generate ElevateSpacing.swift
echo "  → Generating ElevateSpacing.swift..."
generate_spacing_swift "$SPACING_TOKENS" > "$OUTPUT_DIR/Spacing/ElevateSpacing.swift.new"

# Generate ElevateColors.swift
echo "  → Generating ElevateColors.swift..."
generate_colors_swift "$COLOR_TOKENS" > "$OUTPUT_DIR/Colors/ElevateColors.swift.new"

echo ""
echo "✅ Swift code generation complete"
echo ""

echo "📦 Step 3: Backing up existing files..."
echo ""

# Create backup directory with timestamp
BACKUP_DIR="$PROJECT_ROOT/scripts/backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup existing files
cp "$OUTPUT_DIR/Components/ButtonTokens.swift" "$BACKUP_DIR/" 2>/dev/null || true
cp "$OUTPUT_DIR/Spacing/ElevateSpacing.swift" "$BACKUP_DIR/" 2>/dev/null || true
cp "$OUTPUT_DIR/Colors/ElevateColors.swift" "$BACKUP_DIR/" 2>/dev/null || true

echo "  → Backups saved to: $BACKUP_DIR"
echo ""

echo "🔄 Step 4: Updating Swift files..."
echo ""

# Move new files into place
mv "$OUTPUT_DIR/Components/ButtonTokens.swift.new" "$OUTPUT_DIR/Components/ButtonTokens.swift"
mv "$OUTPUT_DIR/Spacing/ElevateSpacing.swift.new" "$OUTPUT_DIR/Spacing/ElevateSpacing.swift"
mv "$OUTPUT_DIR/Colors/ElevateColors.swift.new" "$OUTPUT_DIR/Colors/ElevateColors.swift"

echo "  ✓ ButtonTokens.swift updated"
echo "  ✓ ElevateSpacing.swift updated"
echo "  ✓ ElevateColors.swift updated"
echo ""

echo "🧪 Step 5: Verifying Swift compilation..."
echo ""

cd "$PROJECT_ROOT"
if swift build 2>&1 | grep -q "error:"; then
    echo "❌ Build failed! Restoring from backup..."
    cp "$BACKUP_DIR"/*.swift "$OUTPUT_DIR/Components/" 2>/dev/null || true
    cp "$BACKUP_DIR"/*.swift "$OUTPUT_DIR/Spacing/" 2>/dev/null || true
    cp "$BACKUP_DIR"/*.swift "$OUTPUT_DIR/Colors/" 2>/dev/null || true
    echo "Files restored. Please check the build errors."
    exit 1
else
    echo "✅ Build successful!"
fi

echo ""
echo "=========================================="
echo "✨ Design tokens updated successfully!"
echo ""
echo "Summary:"
echo "  - Button tokens updated with latest colors and sizes"
echo "  - Spacing tokens updated with all measures"
echo "  - Color tokens updated with all tones and states"
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Review the changes: git diff"
echo "  2. Test the UI components in the demo app"
echo "  3. Commit the changes if everything looks good"
echo ""
