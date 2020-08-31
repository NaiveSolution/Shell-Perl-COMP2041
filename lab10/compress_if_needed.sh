#!/bin/bash
for d in $@ ; do
    initial=`wc -c $d | cut -d\  -f1`
    cp $d "$d.copy"
    (xz $d.copy)
    info=`wc -c $d.copy.xz | cut -d " " -f1`
    if test "$initial" -lt "$info"
    then
        rm "$d.copy.xz"
        echo $d $initial bytes, compresses to $info bytes, left uncompressed
    elif test $initial -gt $info
    then
        rm $d
        mv "$d.copy.xz" "$d.xz"
        echo $d $initial bytes, compresses to $info bytes, compressed
    fi
done