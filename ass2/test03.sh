$#
$*
$@

some_routine() {
    $@
    $*
    $1
    $2
    local a b c
    local z='hello' # not yet programmed, should fail
    return 0
}

a=$(echo 4)
b=$(      expr 2 + 2   )
c=$((10 + 10 + $a * 3 \ $1))
echo $((   $a + 3 + 2 - 1))

while test $i -lt 10
do
    if [ ! $i -gt 5 ]
    then
        echo $i
    fi
done

for i in file
do
    while test $i -lt 10
    do
        if [ ! $i -gt 5 ]
        then
            echo $i
            while [ $a -ne $b ]
            do
                for file in *.c
                do
                    echo non-sensical loop logic
                    while `expr 2 + 2` -lt 6 # this isnt even valid shell code at this point
                    do
                        echo this is nuts
                    done
                done
            done
        fi          # lots of spaces after fi
    done                # and this done
done

if [ -r /some/file ]
then
    echo some file exists
    if test -d some/other/file
    then
        echo i dont know what -d does
    fi
else
    echo some file doesnt exist
fi
a=$1
a=$5bbbasd
z=$a$3bbb