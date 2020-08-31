#!/usr/bin/perl -w
my $largest_number;
my $largest_line;

while ($line = <STDIN>) {
	chomp $line;
	@numbers = $line =~ /[-+]?[0-9]*\.?[0-9]+/g;
	foreach $num (@numbers) {
		if (!$largest_number) {
			$largest_number = $num;
			$largest_line = "$line\n";
		} elsif ($largest_number < $num) {
			$largest_number = $num;
			$largest_line = "$line\n";
		} elsif ($largest_number == $num) {
			$largest_line .= "$line\n";
		}
	}

}
print "$largest_line";

