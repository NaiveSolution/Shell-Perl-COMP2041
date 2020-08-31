#!/usr/bin/perl -w

$N = 10;

foreach $arg (@ARGV) {
    	if ($arg eq "--version") {
        	print "$0: version 0.1\n";
        	exit 0;
	} 

	elsif ($arg =~ /^-\d+$/){
		#print "arg is $arg\n";
		$arg =~ tr/\-//d;
		$N = $arg;
		#print "N is $N\n";
	}

	else {
        	push @files, $arg;
    	}
}

if (@files >= 1) {
	foreach $file (@files) {
		open F, '<', $file or die "$0: Can't open $file: $!\n";
		my @lines;
		if (@files != 1){
			print "==> $file <==\n";
		}
		while (my $line = <F>){
			shift @lines if @lines == $N;
			push @lines, $line;		
		}
		print @lines;	
		close F;
	}
} else {
	while ($line = <STDIN>){
		push @lines, $line;
		if ($line eq "\n"){
			last;
		}
	}
	foreach $line (@lines){
		shift @lines if @lines == $N;
	}
	print @lines;
}
