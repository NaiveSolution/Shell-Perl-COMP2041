#!/bin/dash


n=0

while true
do
        if [ ! -d .snapshot."$n" ]
        then
		echo Creating snapshot "$n"
		mkdir .snapshot."$n"
		rsync -Irvq --exclude=.* --exclude snapshot-save.sh --exclude snapshot-save.sh $PWD/ $PWD/.snapshot."$n"/
                break
        fi
        n=`expr $n + 1`
done

