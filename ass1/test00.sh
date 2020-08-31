#!/bin/dash

# Test 01 - testing shrug-init
# This test is testing functionality and conformity to the spec, see
# later tests for more complicated interweaving of functionality

#see what happens if a directory called .shrug already exists
echo Testing init if a .shrug file already exists:
mkdir .shrug
./shrug-init
rm -r .shrug/

# test what happens if we add arguments to init
echo Testing arguments to init:
./shrug-init a
./shrug-init a b

# testing multiple calls of shrug init
echo Testing multiple calls of shrug-init:
./shrug-init
./shrug-init

# testing what happens if there is a file called .shrug
echo Testing if a file called .shrug already exists:
echo a >> .shrug
./shrug-init
rm -r .shrug


