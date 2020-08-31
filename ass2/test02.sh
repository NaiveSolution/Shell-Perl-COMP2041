# test some if statements

if test $a = $b
then
    for i in file
    do
        echo stuff
    done
fi

if  $a -eq $b; then
    echo stuff
fi

if [ ! $a ]
then
    echo level 0
    if test $a
    then
        echo level 1
        if test $a -gt $b
        then
            echo level 2
            if [ $a != "$b" ] -a [ $b = 'poop' ] || test $1 -ne 0
            then
                echo level 3
            elif [ "$1" != $b ] -o [ $2 = 'pewp' ]
            then
                echo elif statements
            else
                echo else statements
            fi
            if test ! $1; then
                echo other format of if statement
            fi
        fi
    fi
fi
a=`expr 1 + 1 * $a '*' $b '\' $c`
b=`expr 1 + `expr 2 + 2`` # wont be translated even thought its valid shell as I have not accounted for nested backticks
echo `expr $a + $1` # shouldnt work, have not accounted for backticks on echo commands
$1
$2
$9
a=$1$2$9