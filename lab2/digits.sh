#!/bin/sh
# transforms numbers less than 5 to '<' and greater than 5 to '>'
# written by Tariq

#set -x

while read string
do
        echo "$string" | tr 0-4 '<' | tr 6-9 '>'
done
