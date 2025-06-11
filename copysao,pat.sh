#!/bin/bash

for m in {45..84}
do
    # Define the source and destination directories
    src_dir="/home/nabin/s_xrt/011268530${m}/auxil"
    dest_dir="/home/nabin/s_xrt/out011268530${m}"

    # Check if the source directory exists
    if [ -d "$src_dir" ]; then
        # Check if the files exist in the source directory
        if [ -e "$src_dir/sw011268530${m}pat.fits.gz" ] && [ -e "$src_dir/sw011268530${m}sao.fits.gz" ]; then
            # Copy the required files to the destination directory
            cp "$src_dir/sw011268530${m}pat.fits.gz" "$dest_dir"
            cp "$src_dir/sw011268530${m}sao.fits.gz" "$dest_dir"
            
            echo "Files copied for run $m"
        else
            echo "Required files not found in source directory for run $m"
        fi
    else
        echo "Source directory not found for run $m"
    fi
done

