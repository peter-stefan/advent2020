#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @list = () ;
my $einser = 0 ;
my $dreier = 0 ;

while (my $line = <IN>) {
   chomp $line ;
   push @list , $line }
close IN ;

my @sorted_list = sort{$a<=>$b} @list ;

my $curval = 0 ;
for my $newval (@sorted_list) {
   chomp $newval ;
   print "$curval - $newval ".($newval-$curval) ;
   if ($newval - $curval == 1) {
      $einser++ ;
      print "+1 ".$einser."\n" }
   elsif ($newval - $curval == 3 ) {
      $dreier++ ;
      print "+3 ".$dreier."\n" }
   $curval = $newval }

print "Last dreier:\n" ;
$dreier++ ;
print "Einser:$einser  Dreier:$dreier  Mal:".$einser*$dreier." \n" ;
