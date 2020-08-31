#!/bin/bash
# inputs: none
# function: converts all .jpg files in the cwd to .png
# written by Tariq

#set -x

for file in *.jpg
do
        convert=$(echo "$file"|sed 's/jpg$/png/')
        if [ -e "$convert" ]
        then
                echo "$convert" already exists
                exit 1
        fi
        gm convert "$file" "$convert"
        rm "$file"
done    
