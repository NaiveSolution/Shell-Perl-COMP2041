#!/bin/bash
# inputs: arg1
# function: reads the file in the cd, and finds out how many lines are in them.
# will output the string small/medium/large based on the amount of lines in each file
# written by Tariq

#set -x
small_array=()
medium_array=()
large_array=()

for file in *
do
	num_files="$(wc -l < $file)"
	if [ -f "$file" ]
	then
		if [ $num_files -gt 100 ]
		then
			large_array+=($file)
		elif [ $num_files -lt 100 ] && [ $num_files -ge 10 ]
		then
			medium_array+=($file)
		else
			small_array+=($file)
		fi
	fi
done

echo -n "Small files: "
for file in "${small_array[@]}"
do
	echo -n "$file "
done
echo ''
echo -n "Medium-sized files: "
for file in "${medium_array[@]}"
do
	echo -n "$file "
done
echo ''
echo -n "Large files: "
for file in "${large_array[@]}"
do
        echo -n "$file "
done
echo ''
