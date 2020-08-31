#!/usr/bin/perl -w
#args:
#functions:
#Written by Tariq

my @lines;

while (my $input = <STDIN>) {

        last if ( $input eq "\n");
        $input =~ tr/0-4/</;
        $input =~ tr/6-9/>/;
        push @lines, $input;
}

foreach (@lines){
        print $_;
}
