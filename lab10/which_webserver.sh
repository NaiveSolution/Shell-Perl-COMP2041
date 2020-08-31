#!/bin/bash
for arg in $@
do
    echo -n "$arg"
    curl -I -s $arg | egrep -i "Server:" | cut -d ":" -f2
done