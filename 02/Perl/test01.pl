#!/usr/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my $correct = 0 ;
while (my $line = <IN>) {
      chomp $line ;
      $line =~ m/(\d+)\-(\d+) (\w): (\w+)/ ;
      my ($low,$high,$char,$passwd) = ($1,$2,$3,$4) ;
      print $line."\n" ;
      my $cnt=0 ;
      while ($passwd =~ /$char/g ) {$cnt++};

      if ($low <= $cnt && $cnt <= $high) {
         $correct++ ;
         print "+" }
      print "|$low|$high|$char|$passwd|$cnt|\n" ;
}

print $correct."\n" ;
close IN ;
