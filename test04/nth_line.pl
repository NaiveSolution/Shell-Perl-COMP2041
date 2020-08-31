#!/usr/bin/perl -w

$n = $ARGV[0];
$i = 1;

open my $out, '<', $ARGV[1] or die "$0: Can't open $ARGV[1]: $!\n";

while ($line = <$out>){
	if ($i == $n){
		print $line;
		exit;
	}
	$i++;
}

