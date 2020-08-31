#!/bin/dash

arg=$1
#set -x
curl --location --silent http://www.timetable.unsw.edu.au/current/"$arg"KENS.html |
        egrep ""$arg"[0-9]{4}" |
        egrep  -v ">"$arg"[0-9]{4}<" |
        #| tr "\"</\\>=." ' '
        sed "s/^.*\(${arg}.*\).*$/\1/" |
        sed 's/<\/a><\/td>//g' |
	sed 's/.html\">/ /g' |
	sort -f |
	uniq
