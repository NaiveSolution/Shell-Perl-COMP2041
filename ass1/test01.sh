#!/bin/dash

# Test 02 - Testing shrug-add
# this test is testing functionality and conformity to the spec, see
# later tests for more complicated interweaving of functionality

# Add files that dont exist in the cwd
echo Testing files that dont exist in the cwd:
./shrug-init
echo a > a
echo b > b
./shrug-add a b c
rm a
rm b

# Add files with invalid names
echo Testing invalid names:
echo hi > '-a'
echo hello > '!!a'
echo fff > '^%#$!#aaaa'
echo a file with a space as a name > ' '
./shrug-add '-a'
./shrug-add '!!a'
./shrug-add '^%#$!#aaaa'
./shrug-add ' '
rm './-a'
rm '!!a'
rm '^%#$!#aaaa'
rm ' '

# Use add on a file that exists in the index but no longer exists in the cwd
echo Testing shrug-add on a deleted file that still is in the index:
echo a > a
./shrug-add a
rm a
./shrug-add a

# Add identical files to the index without using shrug-add, then adding
# to the index using shrug-add
echo Manually adding a file to the index, then using shrug-add to add an identical file to the index
rm -r .shrug
./shrug-init
echo a > a
mv a .shrug/index
echo a > a
./shrug-add a
rm a
rm -r .shrug
