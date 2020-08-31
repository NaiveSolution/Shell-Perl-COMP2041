#!/usr/bin/perl
#$filename = "Makefile";
$date = `date`;
$str = "# Makefile generated at $date\n";
$mainfile = "";
@o_files;
@includes;
#open (FILE, '>', $filename) or die "Cannot open file: $!";
print STDOUT $str;
print STDOUT "CC = gcc\nCFLAGS = -Wall -g\n\n";

for my $file (glob "*.c"){
    #print "current file is: $file\n";
    open my $info, $file or die "Could not open $file: $!";
    ($o_file = $file) =~ s/\.c$/\.o/;
    push @o_files, $o_file;

    while (my $line = <$info>){
        if ($line =~ /^\s*(int|void)\s*main\s*\(/){
            ($mainfile = $file) =~ s/\.c$//;
        }
    }
    close $info
}
print STDOUT "$mainfile:\t@o_files\n\t\$(CC) \$(CFLAGS) -o $@ @o_files\n\n";

for my $file (glob "*.c"){
    my $h_file = "";
    ($o_file = $file) =~ s/\.c$/\.o/;
    print STDOUT "$o_file: ";
    open my $info, $file or die "Could not open $file: $!";
    while (my $line = <$info>){
        if ($line =~ /^\s*#include\s/){
            ($h_file = $line) =~ s/.*["<](.*)[">].*/$1/;
            chomp $h_file;
            print STDOUT "$h_file ";
            #print "for o file $o_file, found h file: $h_file";
        }
    }
    print STDOUT "$file\n";
    close $info
}

#print "main is in: $mainfile\n";
#print "list of o_files are: @o_files\n";
#close FILE;
