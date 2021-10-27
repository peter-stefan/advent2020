#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @list = () ;
my $einser = 0 ;
my $dreier = 0 ;
my $multiple = 1 ;

while (my $line = <IN>) {
   chomp $line ;
   push @list , $line }
close IN ;

my @sorted_list = sort{$a<=>$b} @list ;
# For last step
my $maxval = $sorted_list[-1] ;
push @sorted_list,($maxval+3) ;

my $curval = 0 ;
my $curcnt = 0 ;
for my $newval (@sorted_list) {
   chomp $newval ;
   print "$curval - $newval ".($newval-$curval) ;
   if ($newval - $curval == 1) {
      $einser++ ;
      print "+1 ".$einser."\n" ;
      $curcnt++  }
   elsif ($newval - $curval == 3 ) {
      $dreier++ ;
      print "+3 ".$dreier."\n";
      if ($curcnt == 1) {
         $multiple *= 1 }
      elsif ($curcnt == 2) {
         $multiple *= 2 }
      elsif ($curcnt == 3) {
         $multiple *= 4 }
      elsif ($curcnt == 4) {
         $multiple *= 7 }
      $curcnt = 0 }
   $curval = $newval }

print "Einser:$einser  Dreier:$dreier  Mal:".$einser*$dreier." \n" ;
print "Wege: $multiple \n" ;
