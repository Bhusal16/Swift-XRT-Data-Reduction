#!/bin/bash

m=41
limit=43
log_file="barycor_log.txt"
cobbler="yes"  # Set the variable "cobbler" to "yes"

while [ "$m" -le "$limit" ]; do 
    current_dir="/home/nabin/s_xrt/out011268530$m"

    cd "$current_dir" || { echo "Error: Unable to change directory to $current_dir" >> "$log_file"; continue; }

    # List files in the current directory matching specific patterns
    f1=(*po_cl.evt)
    f2=(*sao.fits.gz)
    f3=(*pat.fits.gz)
    f4=(*xhdtc.hk)

    # Function to run barycorr with error checking and logging
    run_barycorr() {
        if [ -f "$1" ]; then
            barycorr infile="$1" outfile="$2" orbitfiles="$3" >> "$log_file" 2>&1
            if [ $? -ne 0 ]; then
                echo "Error in barycorr for $1" >> "$log_file"
            fi
        fi
    }

    # Run barycorr for each file type
    for file1 in "${f1[@]}"; do
        run_barycorr "$file1" "out011268530${m}_po_cl_bary.evt" "$f2"
    done

    for file3 in "${f3[@]}"; do
        run_barycorr "$file3" "out011268530${m}_pat_bary.fits.gz" "$f2"
    done
    
    for file4 in "${f4[@]}"; do
        run_barycorr "$file4" "out011268530${m}_xhdtc_bary.hk" "$f2"
    done

    cd ..
    ((m++))  # Increment m
done

