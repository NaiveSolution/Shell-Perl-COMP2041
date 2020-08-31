#!/usr/bin/perl -w

$n = $ARGV[0];
my @list;

sub uniq {
  my %seen;
  return grep { !$seen{$_}++ } @_;
}

while ($line = <STDIN>){
    push @list, $line;
    my @unique_words = uniq @list;
    $uniqs = scalar @unique_words;
    if ($uniqs == $n){
        $num_lines = scalar @list;
        print "$n distinct lines seen after $num_lines lines read.\n";
        exit;
    }
}
$num_lines = scalar @list;
print "End of input reached after $num_lines lines read - $n different lines not seen.\n";
exit;
