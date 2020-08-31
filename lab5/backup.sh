#!/bin/bash
#script description: create a backup of input arg1 file, <backup>, and call the backup: <backup>.n; where n is an integer starting from 0. If backup file <backup>.n exists, then <backup>.(n+1) is created.
#input arguments: arg1 = <file>
#Written by Tariq


file=$1
n=0

while true
do
        if ! [ -r ."$file"."$n" ]
        then
                outfile="."$file"."$n""
                cp "$file" "$outfile"
                echo "Backup of '"$file"' saved as '"$outfile"'"
                break
        fi
        n=`expr $n + 1`
done
