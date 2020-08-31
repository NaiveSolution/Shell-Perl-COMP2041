#!/bin/bash

for file in $@
do
	includes=$(cat $file | egrep  '#include' | egrep '"' | cut -d' ' -f2 | sed -e 's/"//g')
	for file2 in $includes
	do
		if [ ! -e $file2 ]
		then
			echo $file2 included into $file does not exist
		fi
	done
done
