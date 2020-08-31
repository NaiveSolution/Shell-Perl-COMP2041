#!/usr/bin/perl

# stackoverflow told me to use this
use File::Basename;
use File::Compare;

# stolen from https://stackoverflow.com/questions/2149368/how-can-i-loop-through-files-in-a-directory-in-perl
opendir(D1, $ARGV[0]);
my @dir1 = readdir(D1);
#print @dir1, "\n";
closedir (D1);
opendir(D2, $ARGV[1]);
my @dir2 = readdir(D2);
closedir (D2);

foreach my $file1 (@dir1){
	#print $file, "\n";
	foreach my $file2 (@dir2){
		#print  $file2, "\n";
		if (basename($file1) eq basename($file2)){
			if (compare($file1, $file2) == 0){
				print basename($file1), "\n";
			}
		}
	}
}

