#!/bin/bash

# SCSS Parser Library
# Functions to parse SCSS variable files and extract design tokens

# Parse rgb() color values and convert to Swift Color
parse_rgb_color() {
    local rgb_string="$1"
    # Extract rgb values: "rgb(11 92 223)" -> "11 92 223"
    local values=$(echo "$rgb_string" | sed 's/rgb(\(.*\))/\1/' | tr '/' ' ')

    if [[ "$rgb_string" == *"rgba"* ]] || [[ "$rgb_string" == *"/"* ]]; then
        # Has alpha channel
        local r=$(echo "$values" | awk '{print $1}')
        local g=$(echo "$values" | awk '{print $2}')
        local b=$(echo "$values" | awk '{print $3}')
        local a=$(echo "$values" | awk '{print $4}')

        # Convert to 0-1 range
        r=$(awk "BEGIN {printf \"%.4f\", $r/255}")
        g=$(awk "BEGIN {printf \"%.4f\", $g/255}")
        b=$(awk "BEGIN {printf \"%.4f\", $b/255}")
        a=$(awk "BEGIN {printf \"%.4f\", $a/255}")

        echo "Color(red: $r, green: $g, blue: $b, opacity: $a)"
    else
        # RGB only
        local r=$(echo "$values" | awk '{print $1}')
        local g=$(echo "$values" | awk '{print $2}')
        local b=$(echo "$values" | awk '{print $3}')

        # Convert to 0-1 range
        r=$(awk "BEGIN {printf \"%.4f\", $r/255}")
        g=$(awk "BEGIN {printf \"%.4f\", $g/255}")
        b=$(awk "BEGIN {printf \"%.4f\", $b/255}")

        echo "Color(red: $r, green: $g, blue: $b)"
    fi
}

# Convert rem to CGFloat
rem_to_cgfloat() {
    local rem_value="$1"
    # Remove 'rem' suffix and convert to float
    local value=$(echo "$rem_value" | sed 's/rem//')
    # Multiply by 16 to get points (standard 1rem = 16pt)
    awk "BEGIN {printf \"%.4f\", $value * 16}"
}

# Extract button tokens from SCSS file
extract_button_tokens() {
    local file="$1"
    local output=""

    # Extract all button-related variables
    while IFS= read -r line; do
        if [[ "$line" =~ ^\$([a-z-]+):.* ]]; then
            local var_name="${BASH_REMATCH[1]}"
            local value=$(echo "$line" | sed 's/^[^:]*: //' | sed 's/var([^,]*, //' | sed 's/);//' | tr -d '\r\n ')

            # Parse based on type
            if [[ "$value" =~ rgb ]]; then
                value=$(parse_rgb_color "$value")
            elif [[ "$value" =~ rem ]]; then
                value=$(rem_to_cgfloat "$value")
            fi

            output+="$var_name=$value"$'\n'
        fi
    done < "$file"

    echo "$output"
}

# Extract spacing tokens from measures file
extract_spacing_tokens() {
    local file="$1"
    local output=""

    while IFS= read -r line; do
        if [[ "$line" =~ ^\$([a-z-]+):.* ]]; then
            local var_name="${BASH_REMATCH[1]}"
            local value=$(echo "$line" | sed 's/^[^:]*: //' | sed 's/var([^,]*, //' | sed 's/);//' | tr -d '\r\n ')

            if [[ "$value" =~ rem ]]; then
                value=$(rem_to_cgfloat "$value")
            fi

            output+="$var_name=$value"$'\n'
        fi
    done < "$file"

    echo "$output"
}

# Extract color tokens from action alias file
extract_color_tokens() {
    local file="$1"
    local output=""

    while IFS= read -r line; do
        if [[ "$line" =~ ^\$([a-z-]+):.* ]]; then
            local var_name="${BASH_REMATCH[1]}"
            local value=$(echo "$line" | sed 's/^[^:]*: //' | sed 's/var([^,]*, //' | sed 's/);//' | tr -d '\r\n ')

            if [[ "$value" =~ rgb ]]; then
                value=$(parse_rgb_color "$value")
            fi

            output+="$var_name=$value"$'\n'
        fi
    done < "$file"

    echo "$output"
}

# Extract token by name from token data
get_token_value() {
    local token_data="$1"
    local token_name="$2"

    echo "$token_data" | grep "^$token_name=" | cut -d'=' -f2-
}
