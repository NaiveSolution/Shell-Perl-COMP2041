#!/usr/bin/perl -w

my $keyword = $ARGV[0];
my $key_count = 0;
my $count = 0;

my %artist_hash;
my %words_hash;
foreach $file (glob "lyrics/*.txt") {
	open F, "$file" or die "Cant open file: $!\n";
	while ($line = <F>) {
		chomp $line;
		$line =~ s/[^a-zA-Z]/ /g;
                $line =~ s/^\s+|\s+$//g;
                $line =~ s/\s+/ /g;
                my @words = split(' ', lc($line));
               	foreach $i (@words) {
                	if (!$artist_hash{$file}{$i}) {
				$artist_hash{$file}{$i} = 1;
			} else {
				$artist_hash{$file}{$i}++;
			}
			if (!$totalWords{$file}) {
				$totalWords{$file} = 1;
			} else {
				$totalWords{$file}++;
			}
        	}
	}
}

foreach $file (glob "lyrics/*.txt") {	
	@files = split("/", $file);
	@artists = split(".txt", $files[1]);
	$artist = $artists[0];
	$artist =~ s/_/ /g;
	#print $artist, "\n";

	open FILE, '<', $file or die "Cant open file: $!\n";
	while ($line = <FILE>){
		chomp $line;
		$line =~ s/[^a-zA-Z]/ /g;
		$line =~ s/^\s+|\s+$//g;
		$line =~ s/\s+/ /g;
		my $string = lc($line);
		if ($line ne ''){
			@words = split (' ', $line);
			foreach $i (@words){
				$i++;
				$count++;	
			}
                	my @match = $string =~ /\b$keyword\b/gi;
                	$key_count = $key_count + scalar @match;
        	}
	}
	close FILE;
	printf("%4d/%6d = %.9f %s\n", $key_count, $count, $key_count/$count, $artist);
	$count = 0;
	$key_count = 0;
}

#print "$keyword occurred $key_count times\n";

