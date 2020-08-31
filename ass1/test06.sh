#!/bin/dash

# Test 06 - Testing shrug-rm semantics

# Testing shrug-rm conformance to spec

# Note: there are 3 places where file checking occurs - the current working directory,
# the index, and the last commit. Checking the differences in the file in 
# each of these places is enough to infer the status of the file

echo "\nTesting shrug-rm semantics.."
echo Testing shrug-rm - file changed in cwd before it is added to index
rm -r .shrug
./shrug-init
echo lollies > a
./shrug-add a
./shrug-commit -m lelel
echo covfefe >> a
./shrug-rm
rm a
echo Testing shrug-rm - file is oldest in the last commit, changed and added to the index after the last commit and changed after adding to the index
echo b > b
./shrug-add b
./shrug-commit -m first
echo b >> b
./shrug-add b
echo b >> b
./shrug-rm b
rm b
rm -r .shrug

# Testing --cached semantics
echo "\nTesting shrug-rm --cached semantics.."
./shrug-init
echo Testing --cached where the file in the cwd is different to the index:
echo lols > a
./shrug-add a
./shrug-commit -m uwu
echo lol >> a
./shrug-rm --cached a
rm a
echo Testing --cached where the all three index, CWD and last commit are different:
echo b > b
./shrug-add b
./shrug-commit -m first
echo b >> b
./shrug-add b
echo b >> b
./shrug-rm --cached b
rm b
rm -r .shrug

echo Testing --cached where the file in the cwd and index are the same, but the last commit is different
./shrug-init
echo a > a
./shrug-add a
./shrug-commit -m fek
echo a >> a
./shrug-add a
./shrug-rm --cached a
rm -r .shrug

# Testing --forced semantics
echo "\nTesting shrug-rm --force semantics.."
./shrug-init
echo a > a
echo Testing --force when the cwd is newer than the index
./shrug-add a
./shrug-commit -m lol
echo a >> a
./shrug-rm --force a
rm a
echo Testing --force when index, cwd and last commit are different
echo b > b
./shrug-add b
./shrug-commit -m second
echo b >> b
./shrug-add b
echo b >> b
./shrug-rm --force b
rm b
echo Testing --forced where the file and index file are same, repo different
echo a > a
./shrug-add a
./shrug-commit -m fek
echo a >> a
./shrug-add a
./shrug-rm --force a
rm -r .shrug
