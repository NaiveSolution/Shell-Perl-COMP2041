#!/usr/bin/perl -w

my @list;
foreach $arg (@ARGV){
	$word = lc $arg;
	if ($word =~ /.*[aeiou]{3}.*/){
		print "$arg ";
	}
	#if ($word =~ /.*e.*i.*o/){
	#	print $word;
	#}
	#if ($word =~ /.*i.*o.*u/){
	#	print $word;
	#}
}
print "\n";
