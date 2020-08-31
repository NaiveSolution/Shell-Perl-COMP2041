#!/bin/dash

# Test 03 - Testing shrug-commit/show
rm -r .shrug
# Testing shrug-shows conformance to spec
echo "\nTesting shrug-show with nothing committed:"
./shrug-init
echo lollies > a
./shrug-add a
./shrug-show :a # should show lollies
echo Testing shrug-show with no file name
./shrug-commit -m first
./shrug-show 0:
echo Testing shrug-show with an invalid commit:
./shrug-show 1:a
echo Testing shrug-show with no commit or file name:
./shrug-show :
echo Testing shrug-show with an invalid filename:
./shrug-show 0:b
./shrug-show :::
rm a

# Testing normal operation of show
echo "\nTesting file contents with more and more appends to it:"
rm -r .shrug
./shrug-init
echo tariq > a
./shrug-add a
./shrug-commit  -m first
echo is >> a
./shrug-add a
./shrug-commit -m second
echo bad at programming >> a
./shrug-add a
./shrug-commit -m third
./shrug-show 0:a # tariq
./shrug-show 1:a # tariq is
./shrug-show 2:a # tariq is bad at programming
rm a



