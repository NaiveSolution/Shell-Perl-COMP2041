#!/bin/dash

n=$1

snapshot-save.sh
echo Restoring snapshot "$n"
rsync -Irvq $PWD/.snapshot."$n"/ $PWD/

