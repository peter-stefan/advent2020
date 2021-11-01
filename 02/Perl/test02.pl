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
      my $c1 = substr($passwd,($low-1),1) ;
      my $c2 = substr($passwd,($high-1),1) ;
      if ($c1 ne $c2 && ($char eq $c1 || $char eq $c2)) {
          $correct++ ;
          print "+" }
      print "|$low|$high|$char|$passwd|$c1|$c2|\n" ;
}

print $correct."\n" ;
close IN ;
