#!/usr/bin/perl -w

while ($line = <STDIN>){
my @list = split ' ', "$line";
#print @list
@list = sort { $a cmp $b } @list;
print "@list\n";
}
