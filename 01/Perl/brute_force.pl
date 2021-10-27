#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'input' ;

my @unsorted = () ;

while (my $line = <IN>) {
  chomp $line ;
  push @unsorted , $line }

my @sorted = sort{$a<=>$b} (@unsorted) ;
my @sorted2 = @sorted ;
my @sorted3 = @sorted ;

for my $a (@sorted) {
    for my $b (@sorted2) {
        for my $c (@sorted3) {
            if (($a+$b+$c) == 2020) {
               print "$a + $b + $c = 2020 \n" ;
               print "$a * $b * $c = ".($a*$b*$c)."\n" }
        }
    }
}

close IN ;
