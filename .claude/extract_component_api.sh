#!/bin/bash

# Extract component API from TypeScript files

ELEVATE_SRC="/Users/wrede/Documents/Elevate-2025-11-04/elevate-core-ui-main/src/components"
OUTPUT_DIR="/Users/wrede/Documents/GitHub/elevate-ios/.claude/components"

# Function to extract component info
extract_component() {
    local file=$1
    local component_name=$(basename "$file" .component.ts)

    # Extract metadata
    local category=$(grep -m1 "@category" "$file" | sed 's/.*@category //' | tr -d '\r\n */')
    local status=$(grep -m1 "@status" "$file" | sed 's/.*@status //' | tr -d '\r\n */')
    local since=$(grep -m1 "@since" "$file" | sed 's/.*@since //' | tr -d '\r\n */')

    # Get description from JSDoc
    local description=$(awk '/\/\*\*/,/\*\// {if (!/\*|@/ && NF) print}' "$file" | head -3 | sed 's/^ *//')

    # Determine output category
    local output_category="Structure"
    case "$category" in
        Navigation) output_category="Navigation" ;;
        Display) output_category="Display" ;;
        Forms) output_category="Forms" ;;
        Structure) output_category="Structure" ;;
        Overlays) output_category="Overlays" ;;
        Feedback) output_category="Feedback" ;;
        Observers) output_category="Observers" ;;
    esac

    if [ -n "$category" ]; then
        echo "$component_name|$output_category|$status|$since"
    fi
}

# Find all component files
find "$ELEVATE_SRC" -name "*.component.ts" | while read file; do
    extract_component "$file"
done | sort
