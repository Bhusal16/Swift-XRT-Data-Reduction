#!/bin/bash

m=77
limit=82

log_dir="/home/nabin/s_xrt/logss"  # Specify the directory for your log files

while [ "$m" -le "$limit" ]; do
    current_dir="/home/nabin/s_xrt/out011268530$m/product011268530$m"
    log_file="$log_dir/log_${m}.txt"

    cd "$current_dir" || { echo "Error: Unable to change directory to $current_dir" >> "$log_file"; ((m++)); continue; }

    f1=(*_po_clsr_corr.lc)
    f2=(*_po_clbkg.lc)

    for x in "${f1[@]}"; do
        lcmath infile="$x" bgfile="${f2[0]}" outfile=csub.lc multi=1. multb=0.1 addsubr=no >> "$log_file"
    done

    cd ..
    ((m++))
done

