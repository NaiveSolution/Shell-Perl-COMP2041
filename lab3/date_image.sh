#!/bin/bash
# inputs: arg1 .. argn
# functions: uses convert to add the time modified in big letters at the
# bottom of the original picture argn, and keeps a copy of the original
# written by Tariq

#set -x

for file in "$@"
do
        filename=$(echo "$file" | cut -d '.' -f1)
        ext=$(echo "$file" | cut -d '.' -f2)
        copy="$filename"_copy."$ext"
        #echo $copy
        cp "$file" "$copy"
        date=$(ls -l "$file" | cut -d ' ' -f6,7,8)
        gm convert -gravity south -pointsize 36 -draw "text 0,10 '$date'" "$copy" "$file"
        echo "$file" was last modified on "$date"

done
