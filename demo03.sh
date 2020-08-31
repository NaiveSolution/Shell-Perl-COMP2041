#!/bin/bash

# The following code was written by Andrew Taylor and can be found at:
# https://cgi.cse.unsw.edu.au/~cs2041/20T2/ under the name plagiarism_detection.reordering.sh.
# The original "test "$file1" = "$file2" && break" line has been changed
# to be able to conform to the shell-perl translation code.


TMP_FILE1=$(echo hello tariq > a)
TMP_FILE2=$(echo hello tariq > b)
substitutions='s/\/\/.*//;s/"[^"]"/s/g;s/[a-zA-Z_][a-zA-Z0-9_]*/v/g'

for file1 in "$@"
do
    for file2 in "$@"
    do
        if test "$file1" = "$file2"
        then
            break
        fi
        a=$(sed "$substitutions" "$file1"|sort >$TMP_FILE1)
        b=$(sed "$substitutions" "$file2"|sort >$TMP_FILE2)
        if diff -i -w $TMP_FILE1 $TMP_FILE2
        then
            echo "$file1 is a copy of $file2"
        fi
    done
done
rm -f $TMP_FILE1 $TMP_FILE2