#!/bin/bash

# test some simple assignments

a=hello
b=" tariq "
c='  how are you     '
d=$a
e="$b"
f=$a$b
g=$a$b$c
h=$a$b$c$d  # I have not accounted for more than 3 variable concatenation, should print $h = $a.$b.$c.$d but instead prints
            # $h = $a.$b.$c;$d

# test some simple echo statements
echo $a
echo "$b"
echo 'testing with single quotes'
echo "testing with double quotes"
echo 'testing with single quotes with "double" quotes inside'
echo quotes 'are' in "random" 'pl"ace"s'
echo $a $b $c
echo `ls`
`ls` # this line should be the same as the previous line

# test some external commands
grep "tariq" file.txt
echo `grep tariq file.txt`
basename $a
dirname $b
