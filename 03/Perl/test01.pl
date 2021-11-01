#!/usr/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my $standpunkt = 0 ;
my $baeume     = 0 ;

while (my $line = <IN>) {
   chomp $line ;

   my $linelength = length ($line) ;
   if ($standpunkt >= $linelength) {
      $standpunkt -= $linelength }

   my $marker = 'O' ;
   my $zielplatz = substr ( $line , $standpunkt , 1 ) ;
   if ($zielplatz eq '#') {
      $marker = 'X' ;
      $baeume++ }
   substr ($line, $standpunkt , 1 , $marker );
   print "$line\n" ;
   $standpunkt += 3 }

print "Baeume:$baeume\n" ;
close IN ;
