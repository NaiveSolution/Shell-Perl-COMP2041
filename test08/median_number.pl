#!/usr/bin/perl -w
my @list = sort { $a <=> $b } @ARGV;
$m = @ARGV/2;
print $list[$m], "\n";
