#!/usr/bin/perl

open F, $ARGV[0] or die "Cannot open file: $!";

my @line2;
while ($line = <F>) {
	chomp $line;
	push @line2, $line;
}

$num = @line2;
#print $num;

if ($num == 0) {
	exit;
} 
if ($num%2 != 0) {
	$mid = $num/2;
	#print "middle is $middle\n";
	print $line2[$mid], "\n";
}
else {
	$mid = $num/2 - 0.5;
	print $line2[$mid],"\n";
	print $line2[$mid+1],"\n";
}
