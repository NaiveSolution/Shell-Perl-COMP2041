# test some simple for loops

for  i      in                            *
do
        a=`basename $i`
        b=`dirname $i`
        c=`dirname $i`"/"`basename $i` # valid shell code, but not expected
        echo "c is: $c"
done

for i in file; do
    echo $i
    read $i # should not work
    read line # should work
done

read line

for i in file1 file2 file3
do
    exit 1
                exit 0
    exit 8008135
            echo line $n $lines
            cd ./tmp/lolol/
    cd ~
done

for i in file1.txt file2.txt file3.txt
do
done
# The only different for loop format expected is "for <statements>; do"
# The following format isnt accounted for and it should break
for i in file?.?xt c*nt?
do;  done
brexit 1

