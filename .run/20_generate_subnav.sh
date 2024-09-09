#!/bin/bash

EXCLUDED_DIRS=(".git" "node_modules" "__pycache__" ".vscode")

# Get the current working directory (root of the project)
ROOT_DIR=$(pwd)

# Function to extract the title from README.md
get_title_from_readme() {
    local readme_path="$1"
    local title
    title=$(grep -m 1 "^# " "$readme_path" | sed 's/^# //')
    echo "$title"
}

# Function to check if README.md contains the generateSubNav comment
contains_generate_subnav_comment() {
    local readme_path="$1"
    grep -q "<!-- generateSubNav -->" "$readme_path"
}

# Function to generate README.md in subfolders
generate_readme_in_subfolders() {
    local parent_dir="$1"
    local readme_path="$parent_dir/README.md"
    
    # Extract title from the current README.md
    local title
    title=$(get_title_from_readme "$readme_path")
    if [[ -z "$title" ]]; then
        title=$(basename "$parent_dir")
    fi

    # Start building the new README.md content
    local new_content="# $title\n\n<!-- generateSubNav -->\n\n"

    # Iterate over subdirectories and add links to each
    for subdir in "$parent_dir"/*/; do
        if [[ -d "$subdir" ]]; then
            local base_dir
            base_dir=$(basename "$subdir")
            local subdir_readme="$subdir/README.md"
            local subdir_title

            # Only generate a link if the subdirectory contains a README.md
            if [[ -f "$subdir_readme" ]]; then
                subdir_title=$(get_title_from_readme "$subdir_readme")

                if [[ -z "$subdir_title" ]]; then
                    subdir_title="$base_dir"
                fi

                # Clean up paths to avoid double slashes
                local clean_parent_dir="${parent_dir%/}"
                local clean_base_dir="${base_dir%/}"

                # Combine paths and ensure no double slashes
                local absolute_path="$clean_parent_dir/$clean_base_dir/README.md"
                absolute_path="/${absolute_path#"$ROOT_DIR/"}"  # Remove root directory and ensure no leading //

                # Replace any instances of double slashes (except the leading slash)
                absolute_path=$(echo "$absolute_path" | sed 's|//|/|g')

                new_content+="* [$subdir_title]($absolute_path)\n"
                echo "Generated link for $absolute_path with title '$subdir_title'"
            else
                echo "Skipped directory (no README.md): $subdir"
            fi
        fi
    done

    # Write the new content back to the README.md
    echo -e "$new_content" > "$readme_path"
}

# Function to walk through directories and generate the subnav content
generate_subnav() {
    local dir_path="$1"

    # Check for README.md in the current directory
    if [[ -f "$dir_path/README.md" ]]; then
        # Check if README.md contains the generateSubNav comment and has subdirectories
        if contains_generate_subnav_comment "$dir_path/README.md"; then
            generate_readme_in_subfolders "$dir_path"
        fi
    else
        echo "Skipped directory (no README.md): $dir_path"
    fi

    # Recurse into subdirectories, avoiding excluded directories
    for subdir in "$dir_path"/*/; do
        # Ensure subdir is a directory
        if [[ -d "$subdir" ]]; then
            local base_dir
            base_dir=$(basename "$subdir")
            if [[ ! " ${EXCLUDED_DIRS[*]} " =~ " ${base_dir} " ]]; then
                generate_subnav "$subdir"
            fi
        fi
    done
}

# Start from the current directory
for dir in */; do
    if [[ -d "$dir" ]]; then
        generate_subnav "$dir"
    fi
done
