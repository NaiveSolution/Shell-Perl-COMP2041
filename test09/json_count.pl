#!/usr/bin/perl -w

open F, $ARGV[1] or die "Cannot open file: $!";

$whale = $ARGV[0];

$sum = 0;
$current = 0;
while ($line = <F>) {
    #print "Current line: $line";
    if ($line =~ /"how_many": ([0-9]{1,5}),/){
        my $nextline = <F>;
        $current = $1;
        if ($nextline =~ /$whale/i){       
            $sum += $current;
        }
    }
}
print "$sum\n";
close F;