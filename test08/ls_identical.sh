#!/bin/bash

# check if the folder contents are the same
if [ "$(ls $1)" ] && [ "$(ls $2)" ]
then
	# check each file in directory 1 with each file in directory 2
	for file1 in $1/*
	do
		for file2 in $2/*
		do
			# if the file names are the same, then check their contents
			if [ "$(basename "$file1")" = "$(basename "$file2")" ]
			then
				if [ -z "$(diff -q "$file1" "$file2")" ]
				then
					echo "$(basename "$file1")"
				fi
			fi
		done
	done
fi

