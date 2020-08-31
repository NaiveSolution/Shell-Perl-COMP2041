#!/usr/bin/perl -w

$start = $ARGV[0];
$end = $ARGV[1];

open my $out, '>>', $ARGV[2] or die "$0: Can't open $ARGV[2]: $!\n";

while ($start <= $end) {
	print $out "$start\n";
	$start = $start + 1;
}

close $out;
