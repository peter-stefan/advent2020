#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @list = () ;

while (my $line = <IN>) {
   chomp $line ;
   push @list , $line }
close IN ;

my $result = 177777905 ;
my $num = scalar @list ;

for my $start (0..$num) {
    my $sum = 0 ;

    my $startval = $list[$start] ;
    my $low = $startval ;
    my $high = $startval ;
    for my $run ($start..$num) {
        my $addval = $list[$run] ;
        if ($high < $addval) { $high = $addval }
        if ($low  > $addval) { $low  = $addval }
        $sum += $addval ;
        if ($sum == $result) {
           print "$start;$run;".$startval.';'.$addval.';'.($high+$low)."\n" ;
           exit 0 }
        elsif ($sum > $result) {
           last }
    }
}

