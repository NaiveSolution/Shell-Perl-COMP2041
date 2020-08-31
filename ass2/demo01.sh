#!/bin/bash

# The following code was written by Andrew Taylor and can be found at:
# https://cgi.cse.unsw.edu.au/~cs2041/20T2/ under the name iota.v1.sh.
# This code has been slightly modified in the "for argument in $@" loop
# to be able to conform to the shell-perl translation code.

if test $# = 1
then
    start=1
    finish=$1
elif test $# = 2
then
    start=$1
    finish=$2
else
    echo "Usage: $0 <start> <finish>"
    exit 1
fi

for argument in "$@"
do
    # clumsy way to check if argument is a valid integer
    if [ ! "$argument" -eq "$argument" ]
    then
        echo "$0: argument '$argument' is not an integer"
        exit 1
    fi
done

number=$start
while test $number -le $finish
do
    echo $number
    number=`expr $number + 1`    # or number=$(($number + 1))
done

echo "dollar star is : $#"