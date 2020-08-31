#!/bin/dash
cat $1 | egrep "name" | cut -d ':' -f2 | cut -d '"' -f2 | sort | uniq