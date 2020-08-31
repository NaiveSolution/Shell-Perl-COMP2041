#!/usr/bin/perl -w

my $keyword = $ARGV[0];
my $key_count = 0;
while ($line = <STDIN>){
	chomp $line;
	$line =~ s/[^a-zA-Z]/ /g;
	$line =~ s/^\s+|\s+$//g;
	$line =~ s/\s+/ /g;
	#print $line, "\n";
	my $string = lc($line);
	if ($line ne ''){
                my @match = $string =~ /\b$keyword\b/gi;
                $key_count = $key_count + scalar @match;
        }
	
}

print "$keyword occurred $key_count times\n";
