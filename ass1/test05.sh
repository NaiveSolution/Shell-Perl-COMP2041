#!/bin/dash

# Test 05 - Testing shrug-rm
# See next test for semantics

# Testing shrug-rm conformance to spec
echo "\nTesting shrug-rm with basic input validation"
rm -r .shrug
echo Testing shrug-rm with no arguments
./shrug-init
echo lollies > a
./shrug-add a
./shrug-commit -m lelel
./shrug-rm
echo Testing shrug-rm with non-existent file:
./shrug-rm b
echo Testing shrug-rm with filename that looks like a flag:
./shrug-rm -b
echo Testing shrug-rm with file that isnt in the index yet:
./shrug-rm a
echo Testing shrug-rm with a file that was added to index and manually removed from cwd by user
./shrug-add a
rm a
./shrug-rm a
echo Testing shrug-rm on a file that is removed from the index manually by the user
echo a > a
./shrug-add a
rm .shrug/index/a
./shrug-rm a
echo Testing shrug-rm when .shrug doesnt even exist
rm -r .shrug
./shrug-rm a
rm a

# Testing shrug-rm --cached with conformance to spec
echo "\nTesting shrug-rm --cached.."
echo Testing shrug-rm --cached with arguments in wrong places:
./shrug-init
echo woof > a
./shrug-add a
./shrug-commit -m lol
./shrug-rm a --cached
echo Testing shrug-rm --cached with no argument
./shrug-rm --cached
echo Testing shrug-rm --cached when file manually deleted from index:
echo meow > a
./shrug-add a
rm .shrug/index/a
./shrug-rm --cached a
rm -r .shrug

# Testing shrug-rm --force with conformance to spec
echo "\nTesting shrug-rm --force.."
echo Testing shrug-rm --force with arguments in wrong places:
./shrug-init
echo poo > a
./shrug-add a
./shrug-commit -m lulul
./shrug-rm a --force
echo Testing shrug-rm --force with no argument
./shrug-rm --force
echo Testing shrug-rm --force on a file that does not exist
./shrug-rm --force b
rm -r .shrug

# Testing shrug-rm --force and --cached together and their conformance
echo "\nTesting shrug-rm --force --cached .."
echo Testing shrug-rm --cached --force '(wrong order)'
./shrug-init
echo hnnngg > a
./shrug-add a
./shrug-commit -m pewpew
./shrug-rm --cached --force a
./shrug-rm --cached a --force
./shrug-rm a --cached --force
echo Testing --force and --cached but with no arguments
./shrug-rm --force --cached
echo Testing with more than one --force and --cached arguments
./shrug-rm --force --cached a --force
./shrug-rm --force --cached --force a
echo Testing --force --cached with a file that doesnt exist
./shrug-rm --force --cached b

