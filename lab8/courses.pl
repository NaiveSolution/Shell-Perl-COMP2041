#!/usr/bin/perl -w

# Subroutine shamelessly copied from SO at:
# https://stackoverflow.com/questions/7651/how-do-i-remove-duplicate-items-from-an-array-in-perl

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

$arg = $ARGV[0];
use LWP::Simple;
$url = "http://www.timetable.unsw.edu.au/current/${arg}KENS.html";
$page = get $url;
my @matches = $page =~ /$arg[0-9]{4}\..*/g;
my @filtered = uniq(sort @matches);

foreach my $line (@filtered){
        if ($line !~ />$arg[0-9]{4}</g) {
                $line =~ s/.html\">/ /g;
                $line =~ s/<\/a><\/td>//g;
                print $line, "\n";
        }
}

