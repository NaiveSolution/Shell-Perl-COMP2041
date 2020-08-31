#!/usr/bin/perl -w

open FILE, '<', $ARGV[0] or die "Bad file!";
my @file = <FILE>;
close FILE;

open FILE, '>', $ARGV[0] or die "Bad file!";

foreach $line (@file) {
    $line =~ s/[0-9]/#/g;
    print FILE $line;
}
close FILE;

