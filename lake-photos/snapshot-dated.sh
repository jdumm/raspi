#!/bin/bash
outdir=/home/pi/projects/timelapse/backyard
mkdir -p $outdir
iname=$outdir/`date`.jpg
iname=${iname//" "/_}
raspistill -o $iname -t 0
