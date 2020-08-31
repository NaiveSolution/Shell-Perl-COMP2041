#!/bin/dash

# Test 04 - Testing shrug-commit/show with -a command
rm -r .shrug
# Testing shrug-commit -a conformance to spec
echo "\nTesting shrug-commit with -a in wrong place"
./shrug-init
echo lollies > a
./shrug-add a
./shrug-commit -m first -a
./shrug-commit -m -a first
echo Testing shrug-commit with no -m flag:
./shrug-commit -a first
echo Testing shrug-commit with multiple -a and/or -m flags:
./shrug-commit -a -m first -a -m second
echo Testing shrug-commit with only an -a flag
./shrug-commit -a

# Testing shrug-commit -a normal operation and semantics
echo "\nTesting shrug-commit -a"
rm -r .shrug
echo lol > a
./shrug-init
./shrug-add a
echo lollies >> a
./shrug-commit -a -m first
if [ -n "$(ls -d .shrug/Repository/0)" ]; then
	echo Success: shrug-commit -a copied file 'a' to the commit folder
else
	echo Failure: shrug-commit -a did not copy file 'a' to the correct folder
fi
if [ -z "$(diff -q a .shrug/index/a)" ]; then
	echo Success: shrug-commit -a copied contents of file 'a' to the index
else
	echo Failure: shrug-commit -a did not copy contents of file 'a'
fi
echo "\nTesting the index file and log produced by shrug-commit -a"
./shrug-log # should print - 0 first
./shrug-show 0:a # should print lol \n lollies

rm -r .shrug
