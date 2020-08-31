#!/usr/bin/perl -w

#print "number of args in ARGV is ",  $#ARGV+1;
$i = 0;


#die "./echon.pl: argument 1 must be a non-negative integer" if  $ARGV[0] !~ /^\d+$/;
#die "./echon.pl: argument 1 must be a non-negative integer" if $ARGV[0] < 0;
#die "Usage: ./echon.pl <number of lines> <string>" if @ARGV != 2;

if (@ARGV != 2){
	print "Usage: ./echon.pl <number of lines> <string>\n";
	exit 1;
}
if ($ARGV[0] !~ /^\d+$/){
        print "./echon.pl: argument 1 must be a non-negative integer\n";
        exit 1;
}
if ($ARGV[0] < 0){
        print "./echon.pl: argument 1 must be a non-negative integer\n";
        exit 1;
}

while ($i < $ARGV[0]) {
	print "$ARGV[1]\n";
	$i++;
}
#print $first;
#print $last;


#print "\n";


