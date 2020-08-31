#!/usr/bin/perl
$date = `date`;
$str = "# Makefile generated at $date\n";
$mainfile = "";
@o_files;
@includes;
print STDOUT $str;
print STDOUT "CC = gcc\nCFLAGS = -Wall -g\n\n";

for my $file (glob "*.c"){
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
print STDOUT "$mainfile:\t@o_files\n\t\$(CC) \$(CFLAGS) -o \$\@ @o_files\n\n";

my @h_files;
for my $file (glob "*.c"){
    ($o_file = $file) =~ s/\.c$/\.o/;
    open my $info, $file or die "Could not open $file: $!";
    while (my $line = <$info>){
        if ($line =~ /^\s*#include ".*\s/){
            ($h_file = $line) =~ s/.*"(.*)"/$1/;
            push @h_files, $h_file;
        }
    }
    print STDOUT "$o_file: @h_files $file\n" if scalar @h_file;
    close $info
}
