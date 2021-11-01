#!/usr/bin/perl

use strict ;
use warnings ;

my @spruenge = ( 1 , 3 , 5 , 7 ) ;
my $endausgabe = "Alle Ergebnisse:\n" ;

for my $sprung (@spruenge) {
  my $standpunkt = 0 ;
  my $baeume     = 0 ;

  open IN , 'daten' ;
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
     $standpunkt += $sprung }

  $endausgabe .= "Sprung:$sprung Baueme:$baeume\n" ;

  close IN }

  my $standpunkt = 0 ;
  my $baeume     = 0 ;
  my $sprung     = 1 ;

  open IN , 'daten' ;
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
     $standpunkt += $sprung ;
     $line = <IN> }

  $endausgabe .= "Sprung:$sprung Baueme:$baeume\n" ;

  close IN ;

print $endausgabe ;
