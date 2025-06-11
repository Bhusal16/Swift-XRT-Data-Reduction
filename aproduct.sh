#!/bin/bash

m=55
limit=58
log_dir="/home/nabin/s_xrt/logs"  # Specify the directory for your log files

while [ "$m" -le "$limit" ]; do
    current_dir="/home/nabin/s_xrt/out011268530$m"
    log_file="$log_dir/log_${m}.txt"

    cd "$current_dir" || { echo "Error: Unable to change directory to $current_dir" >> "$log_file"; let m=$m+1; continue; }

    # Avoid parsing ls output
    f1=(*_po_cl_bary.evt)
    f2=(*po_ex.img)
    f3=(*pat_bary.fits.gz)
    f4=(*xhdtc_bary.hk)

    for x in "${f1[@]}"; do
        xrtproducts infile="$x" expofile="${f2[0]}" outdir="./product011268530$m" stemout=DEFAULT regionfile=DEFAULT ra=288.3 dec=19.7 radius=20 bkgextract=yes bkgregionfile="ds9_b.reg" hdfile="${f4[0]}" attfile="${f3[0]}" clobber=yes pilow=20 pihigh=1000 >> "$log_file" 

        # Check the return status of the xrtproducts command
        if [ $? -ne 0 ]; then
            echo "Error: xrtproducts command failed for $x" >> "$log_file"
        fi
    done

    cd ..

    let m=$m+1
done

