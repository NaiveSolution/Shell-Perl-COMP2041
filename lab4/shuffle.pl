#!/usr/bin/perl -w

my @seq;

open F, '<', $ARGV[0] or die "$0: Can't open $ARGV[0]: $!\n";

while ($line = <F>){
	push @seq, $line;
		
}
$i = @seq;
# Fisher Yates Shuffle: https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm

while (--$i) {
        $j = int rand ($i+1);
        @seq[$i,$j] = @seq[$j,$i];
}

print @seq;
close F;
