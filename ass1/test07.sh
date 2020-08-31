#!/bin/dash

# Test 07 - Testing shrug-status

# Note: there are 3 places where file checking occurs - the current working directory,
# the index, and the last commit. Checking the differences in the file in 
# each of these places is enough to infer the status of the file

# Testing shrug-status semantics
echo "\nTesting shrug-status - a list of untracked files."
rm -r .shrug
shrug-init
echo a > a
echo b > b
echo c > c
./shrug-status
rm a b c

echo "\nTesting shrug-status - a file that that is the same in index/cwd/repo"
echo a > a
shrug-add a
shrug-commit -m lol
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that has been changed after its commit; in other words, the file in the cwd differs from the index and repo file"
shrug-init
echo a> a
shrug-add a
shrug-commit -m aaaaaaaaaaaaa
echo a >> a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that is different in the index, cwd, and repo"
shrug-init
echo a > a
shrug-add a
shrug-commit -m first
echo a >> a
shrug-add a
echo a>> a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that has been updated and added to the index after the last commit"
shrug-init
echo a > a
shrug-add a
shrug-commit -m 'this fuckin module took me so long - look at how stupid shrug-update is'
echo a >> a
shrug-add a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that has been added to the index, not yet committed"
shrug-init
echo a > a
shrug-add a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that has been added to the index, and then deleted from the cwd"
shrug-init
echo a > a
shrug-add a
rm a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that has been added to the index, and then updated, but not yet committed"
shrug-init
echo a > a
shrug-add a
echo a >> a
shrug-status
rm a
rm -r .shrug

echo "\nTesting shrug-status - a file that is in the last commit, but removed from the cwd and the index"
shrug-init
echo a > a
shrug-add a
shrug-commit -m first
shrug-rm a
shrug-status
rm a
rm -r .shrug

