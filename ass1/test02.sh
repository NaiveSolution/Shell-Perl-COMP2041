#!/bin/dash

# Test 03 - Testing shrug-commit/log
rm -r .shrug
# Testing commits conformance to spec
echo "\nTesting shrug-commit with nothing in index:"
./shrug-init
echo a > a
./shrug-commit -m lol
echo Testing shrug-commit with no message:
./shrug-add a
./shrug-commit -m
echo Testing shrug-commit with an invalid message:
./shrug-commit -m -m
echo Testing shrug-commit with newline characters in the message:
./shrug-commit -m "hello\ntariq"
rm a

# Testing if we can commit an invalid file into the repo by bypassing shrug-add
echo "\nTesting if an invalid file can be committed:"
echo bogus file > .shrug/index/"&&!!.txt"
./shrug-commit -m lol
rm .shrug/index/"&&!!.txt"

# Testing what happens if we create the repository files before shrug-commit does
echo "\nTesting if the whole thing breaks if we create a commit file manually:"
rm -r .shrug
./shrug-init
echo a > a
./shrug-add a
mkdir .shrug/Repository/0
./shrug-commit -m lollies # this creates .shrug/Repository/0 , should now make ../1
echo b > b
echo c > c
./shrug-add b c
./shrug-commit -m 'dont break'
./shrug-log #this should skip commit 0 and print 1 lollies --> 2 dont break

# Testing if we can just add a whole bunch of folders to the repo and get log to show
# a silly amount of commits
echo "\nTesting a crazy amount of manual file insertions in .shrug/Repository:"
rm -r .shrug
./shrug-init
echo a > a
./shrug-add a
i=0
while [ "$i" -ne 19 ]
do
	mkdir .shrug/Repository/"$i"
	i="$(expr $i + 1)"	
done
./shrug-commit -m lel
./shrug-log # this should print 20 lel. It doesnt though??

# Testing if we can use an empty string for a commit message
echo "\nTesting empty string or whitespace as message for commit:"
rm -r .shrug
./shrug-init
echo a > a
./shrug-add a
./shrug-commit -m '' # Or
./shrug-commit -m ' '
./shrug-log # this should print an error message

rm -r .shrug





