#!/bin/bash

input=("$@")

first=$1
second=$2
third=$3

#echo $first $second $third

while [ $first -le $second ]
do
	echo $first >> $third
	first=`expr $first + 1`
	#echo $first
done

