#!/usr/bin/perl -w

$sum = 0;
while ($line = <STDIN>){
	chomp $line;
	$line =~ s/[^a-zA-Z]/ /g;
	$line =~ s/^\s+|\s+$//g;
	$line =~ s/\s+/ /g;
	@words = split(/[^a-zA-Z]/, $line);
	$len = @words;
	$sum = $sum + $len;
}

print "$sum words\n";
