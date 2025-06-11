#!/bin/bash
m=37
limit=37

while [ "$m" -le "$limit" ]
do
   xrtpipeline indir=./011268530$m steminputs=sw011268530$m outdir=./out011268530$m srcra=288.3 srcdec=19.7 createexpomap=yes clobber=yes cleanup=no &>log011268530$m


    let m=$m+1
done

