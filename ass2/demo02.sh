#!/bin/bash

# The following code was written by Andrew Taylor and can be found at:
# https://cgi.cse.unsw.edu.au/~cs2041/20T2/ under the name plagiarism_detection.simple_diff.sh.
# The original "test "$file1" = "$file2" && break" line has been changed
# to be able to conform to the shell-perl translation code.

for file1 in "$@"
do
    for file2 in "$@"
    do
        if test "$file1" = "$file2"
        then
            break
        fi
        if diff -i -w "$file1" "$file2"
        then
            echo "$file1 is a copy of $file2"
        fi
    done
done