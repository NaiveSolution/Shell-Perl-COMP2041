#!/bin/bash

#set -x

for file in *.htm
do
        html_file="$file"l
        if [ -e "$html_file" ]
        then
                echo "$html_file exists"
                exit 1
        else
                mv "$file" "$html_file"
        fi
done
