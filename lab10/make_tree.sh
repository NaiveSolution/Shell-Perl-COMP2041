#!/bin/bash
for d in $1 ; do
    for val in $(find $d | grep "Makefile" | cut -d "M" -f1); do
        dir=$(echo $val | sed 's/\/$//')
        echo "Running make in $dir"
        (cd $val && make $2)
    done
done