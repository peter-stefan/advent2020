#!/usr/bin/perl

# Solution for the first quest

use strict ;
use warnings ;

open IN , '../input' ;

my @unsorted = () ;

while (my $line = <IN>) {
  chomp $line ;
  push @unsorted , $line }

my @sorted = sort{$a<=>$b} (@unsorted) ;

my $high = pop   @sorted ;
my $low  = shift @sorted ;

while (($high+$low) != 2020) {
    print "$low + $high != 2020 :-( \n" ;
    my $highneeded = 2020 - $high ;
    if ($low < $highneeded) { 
       $low =  shift @sorted }
    else                    {
       $high = pop @sorted   }
}

print "Thats it: $low + $high = 2020 \n" ;
print "$low * $high =".$low*$high . "\n" ;

close IN ;
