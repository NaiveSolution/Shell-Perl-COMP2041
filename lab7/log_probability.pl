#!/usr/bin/perl -w

my $keyword = $ARGV[0];
my $key_count = 0;
my $count = 0;

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
	printf("log((%d+1)/%6d) = %8.4f %s\n", $key_count, $count, log(($key_count+1)/$count), $artist);
	$count = 0;
	$key_count = 0;
}

#print "$keyword occurred $key_count times\n";
