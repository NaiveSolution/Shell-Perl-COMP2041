#!/usr/bin/perl -w

open my $f1, '<', $ARGV[0] or die "Bad file!";
my @file = <$f1>;
close $f1;


for ($i = 1; $i < @ARGV; $i++) {
	open FILE,'<', $ARGV[$i] or die "Bad file!";
	while (my $line = <FILE>){
		if ($line != $file[$i] ){
			print "files dont match!";
			last;
		}
	}
	close FILE; 
}

