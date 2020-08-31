#!/bin/sh
# inputs: arg1, arg2
# function: prints string arg2, n x arg1 times, only if arg1 is a 
# non-negative integer 
# written by Tariq

#set -x
start=0

input=("$@")

first=${input[0]}
second=${input[1]}

#echo $first
#echo $second

#if test if there is no input at all
if test -z $first
then
        echo "Usage: ./echon.sh <number of lines> <string>"
        exit 1
fi

# test if there is more than 2 inputs
if test ${#input[@]} -gt 2
then
        echo "Usage: ./echon.sh <number of lines> <string>"
        exit 1
fi

#if ! [[ "$first" =~ ^[^0-9]+$ ]]
#then
#       echo "argument 1 must be a non-negative integer"
#       exit 1
#fi

#test if the first input is a string, then print n times if it is
if test $first -lt 0 2>/dev/null || ! [[ "$first" =~ ^[0-9]+$ ]]
    then
        echo "./echon.sh: argument 1 must be a non-negative integer" 
        exit 1
    else
        while test $start -lt $1
        do
            echo $2
            start=$(($start + 1))
        done
fi
