#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;

open IN , 'daten' ;

my @list = () ;
my %hash = () ;
my $einser = 0 ;
my $dreier = 0 ;

while (my $line = <IN>) {
   chomp $line ;
   push @list , $line ;
   $hash{$line} = '' }
close IN ;
push @list , 0 ;
$hash{0} = '' ;
push @list , 141 ;
$hash{141} = '' ;

my @sorted_list = sort{$a<=>$b} @list ;

for my $value (@sorted_list) {
    my $bef = '' ;
    my $string = '' ;
    if (exists $hash{$value+1}) {
       $string .= ($value+1) ;
       $bef = ';' }
    if (exists $hash{$value+2}) {
       $string .= $bef.($value+2) ;
       $bef = ';' }
    if (exists $hash{$value+3}) {
       $string .= $bef.($value+3) }
    $hash{$value} = $string }

my @newlist = (0) ;
my $ways = 0 ;

while (scalar @newlist > 0) {
   my $value = pop @newlist ;
   if ($value == 141) {
      $ways++ }
   else {
      my @subs = split /;/ , $hash{$value} ;
      push @newlist , @subs }
}

print "Ways:$ways\n" ;

