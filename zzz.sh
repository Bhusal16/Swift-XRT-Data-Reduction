#!/bin/bash

# Source directory
source_dir="/home/nabin/s_xrt"

# Destination directory
destination_dir="$source_dir/v"

# Ensure the destination directory exists
mkdir -p "$destination_dir"

# Counter for naming files
m=1

# Find all csub.lc files in the source directory and its subdirectories
find "$source_dir" -type f -name "csub.lc" | while read -r file_path; do
    # Get the directory containing the file
    dir_path=$(dirname "$file_path")
    # Get the file name without the directory path
    file_name=$(basename "$file_path")
    # Modify the file name to csub$m.lc
    new_file_name="csub${m}.lc"
    # Copy the file to the destination directory with the new name
    cp "$file_path" "$destination_dir/$new_file_name"
    echo "Copied $file_path to $destination_dir/$new_file_name"
    # Increment the counter
    ((m++))
done

