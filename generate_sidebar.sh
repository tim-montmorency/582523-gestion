#!/bin/bash

EXCLUDED_DIRS=(".git" "node_modules" "__pycache__" ".vscode")
SIDEBAR_FILE="_sidebar.md"

# Function to extract the title from README.md
get_title_from_readme() {
    local readme_path="$1"
    local title
    title=$(grep -m 1 "^# " "$readme_path" | sed 's/^# //')
    echo "$title"
}

# Start writing to _sidebar.md
> "$SIDEBAR_FILE"  # Clear the file, but don't write a header

# Function to walk through directories and generate the sidebar
generate_sidebar() {
    local dir_path="$1"
    local indent="$2"

    # Check for README.md in the current directory
    if [[ -f "$dir_path/README.md" ]]; then
        local title
        title=$(get_title_from_readme "$dir_path/README.md")
        if [[ -z "$title" ]]; then
            title=$(basename "$dir_path")
        fi
        # Remove any double slashes from the path
        local clean_path
        clean_path=$(echo "$dir_path/" | sed 's://:/:g')
        echo "$indent* [$title]($clean_path)" >> "$SIDEBAR_FILE"
        echo "Added: $clean_path with title '$title'"
    else
        echo "Skipped directory (no README.md): $dir_path"
    fi

    # Recurse into subdirectories, avoiding too deep recursion
    for subdir in "$dir_path"/*/; do
        # Ensure subdir is a directory and avoid overly deep nesting
        if [[ -d "$subdir" ]]; then
            local base_dir
            base_dir=$(basename "$subdir")
            if [[ ! " ${EXCLUDED_DIRS[*]} " =~ " ${base_dir} " ]]; then
                generate_sidebar "$subdir" "  $indent"
            fi
        fi
    done
}

# Start from the current directory
for dir in */; do
    if [[ -d "$dir" ]]; then
        generate_sidebar "$dir" ""
    fi
done
