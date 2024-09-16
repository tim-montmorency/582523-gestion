#!/bin/bash

EXCLUDED_DIRS=(".git" "node_modules" "__pycache__" ".vscode")

# Get the current working directory (root of the project) and ensure it ends with a slash
ROOT_DIR=$(pwd)
ROOT_DIR="${ROOT_DIR%/}/"

# Function to extract the title from README.md
get_title_from_readme() {
    local readme_path="$1"
    local title
    title=$(grep -m 1 "^# " "$readme_path" | sed 's/^# //')
    echo "$title"
}

# Function to check if README.md contains the generateMermaidNav comment
contains_generate_mermaid_nav_comment() {
    local readme_path="$1"
    grep -q '<!-- generateMermaidNav -->' "$readme_path"
}

# Function to generate the Mermaid diagram content recursively
generate_mermaid_content() {
    local parent_dir="$1"
    local parent_id="$2"
    local content_lines=()
    local subdirs=()

    # Remove trailing slash from parent_dir if any
    parent_dir="${parent_dir%/}"

    # Iterate over subdirectories
    for subdir in "$parent_dir"/*/; do
        if [[ -d "$subdir" ]]; then
            # Remove trailing slash from subdir
            subdir="${subdir%/}"

            local base_dir
            base_dir=$(basename "$subdir")

            # Skip excluded directories
            if [[ " ${EXCLUDED_DIRS[*]} " =~ " ${base_dir} " ]]; then
                continue
            fi

            local subdir_readme="$subdir/README.md"
            local subdir_title="$base_dir"

            # Use title from README.md if available
            if [[ -f "$subdir_readme" ]]; then
                local title_from_readme
                title_from_readme=$(get_title_from_readme "$subdir_readme")
                if [[ -n "$title_from_readme" ]]; then
                    subdir_title="$title_from_readme"
                fi
            fi

            # Get relative path from ROOT_DIR
            local relative_subdir="${subdir#$ROOT_DIR}"
            relative_subdir="${relative_subdir#/}"   # Remove leading slash

            # Generate a unique node ID based on relative path
            local node_id
            if [[ -z "$relative_subdir" ]]; then
                node_id="root"
            else
                node_id=$(echo "$relative_subdir" | sed 's/[^a-zA-Z0-9]/_/g')
            fi

            # Construct the link path with /#/ prefix
            local link_path="/#/$relative_subdir/"
            # Ensure there are no double slashes
            link_path=$(echo "$link_path" | sed 's#//*#/#g')

            # Escape special characters in titles
            subdir_title=$(echo "$subdir_title" | sed 's/"/\\"/g')

            # Add the node definition with clickable link
            content_lines+=("    $node_id[\"$subdir_title\"]")
            content_lines+=("    click $node_id \"$link_path\"")

            # Add the edge from parent to child if parent exists
            if [[ -n "$parent_id" ]]; then
                content_lines+=("    $parent_id --> $node_id")
            fi

            # Collect subdirectories for further processing
            subdirs+=("$subdir:$node_id")
        fi
    done

    # Process subdirectories recursively
    for entry in "${subdirs[@]}"; do
        IFS=':' read -r subdir child_id <<< "$entry"
        sub_content=$(generate_mermaid_content "$subdir" "$child_id")
        content_lines+=("$sub_content")
    done

    # Return the content lines
    printf "%s\n" "${content_lines[@]}"
}

# Function to update README.md with the new Mermaid diagram content
update_readme_with_mermaid() {
    local readme_path="$1"
    local mermaid_content="$2"
    local tmpfile=$(mktemp)
    local in_section=0
    local start_tag_found=0
    local end_tag_found=0

    while IFS= read -r line || [ -n "$line" ]; do
        if [[ "$line" == *'<!-- generateMermaidNav -->'* ]]; then
            echo "$line" >> "$tmpfile"
            in_section=1
            start_tag_found=1
            # Write the mermaid content immediately after the start tag
            echo '```mermaid' >> "$tmpfile"
            echo "$mermaid_content" >> "$tmpfile"
            echo '```' >> "$tmpfile"
        elif [[ "$line" == *'<!-- generateMermaidNavEnd -->'* ]]; then
            echo "$line" >> "$tmpfile"
            in_section=0
            end_tag_found=1
        elif [[ $in_section -eq 0 ]]; then
            echo "$line" >> "$tmpfile"
        fi
        # If in_section is 1 (between tags), skip the line
    done < "$readme_path"

    if [[ $start_tag_found -eq 1 && $end_tag_found -eq 0 ]]; then
        # Add the end tag if it was missing
        echo "<!-- generateMermaidNavEnd -->" >> "$tmpfile"
    fi

    if [[ $start_tag_found -eq 0 ]]; then
        # Start tag not found; append the content at the end of tmpfile
        {
            echo -e "\n<!-- generateMermaidNav -->"
            echo '```mermaid'
            echo "$mermaid_content"
            echo '```'
            echo "<!-- generateMermaidNavEnd -->"
        } >> "$tmpfile"
    fi

    # Replace the original file with the updated content
    mv "$tmpfile" "$readme_path"
}

# Function to generate Mermaid diagram in README.md
generate_mermaid_in_readme() {
    local dir_path="$1"
    local readme_path="$dir_path/README.md"

    # Get relative path from ROOT_DIR
    local relative_dir="${dir_path#$ROOT_DIR}"
    relative_dir="${relative_dir#/}"   # Remove leading slash

    # Generate the root node ID
    local root_id
    if [[ -z "$relative_dir" ]]; then
        root_id="root"
    else
        root_id=$(echo "$relative_dir" | sed 's/[^a-zA-Z0-9]/_/g')
    fi

    local title
    title=$(get_title_from_readme "$readme_path")
    if [[ -z "$title" ]]; then
        title=$(basename "$dir_path")
    fi
    title=$(echo "$title" | sed 's/"/\\"/g')

    # Start the Mermaid content as an array
    local mermaid_lines=()
    mermaid_lines+=("flowchart LR")
    mermaid_lines+=("    $root_id[\"$title\"]")

    # Generate the rest of the content
    local sub_content
    sub_content=$(generate_mermaid_content "$dir_path" "$root_id")
    if [[ -n "$sub_content" ]]; then
        mermaid_lines+=("$sub_content")
    fi

    # Combine the lines into a single string
    local mermaid_content
    mermaid_content=$(printf "%s\n" "${mermaid_lines[@]}")

    # Update the README.md with the new mermaid content
    update_readme_with_mermaid "$readme_path" "$mermaid_content"
}

# Function to walk through directories and generate the mermaid content
generate_mermaid_nav() {
    local dir_path="$1"

    # Remove trailing slash from dir_path if any
    dir_path="${dir_path%/}"

    # Check for README.md in the current directory
    if [[ -f "$dir_path/README.md" ]]; then
        # Check if README.md contains the generateMermaidNav comment
        if contains_generate_mermaid_nav_comment "$dir_path/README.md"; then
            generate_mermaid_in_readme "$dir_path"
        fi
    else
        echo "Skipped directory (no README.md): $dir_path"
    fi

    # Recurse into subdirectories, avoiding excluded directories
    for subdir in "$dir_path"/*/; do
        # Ensure subdir is a directory
        if [[ -d "$subdir" ]]; then
            # Remove trailing slash from subdir
            subdir="${subdir%/}"

            local base_dir
            base_dir=$(basename "$subdir")
            if [[ ! " ${EXCLUDED_DIRS[*]} " =~ " ${base_dir} " ]]; then
                generate_mermaid_nav "$subdir"
            fi
        fi
    done
}

# Start from the root directory
generate_mermaid_nav "$ROOT_DIR"
