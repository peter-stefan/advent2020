#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


open IN , "daten" ;

my $zeit = <IN> ;
$zeit = 0 ;

my $zeile = <IN> ;
chomp $zeile ;

close IN ;

my @busse = () ;

my @linien = split /,/ , $zeile ;

for my $linie (@linien) {
    if ($linie ne 'x') {
       push (@busse,$zeit.';'.$linie) }
    $zeit++ }
       
my $first = shift @busse ;

my ($null,$linie) = split /;/, $first ;

my $runde = 5000000000000 ;
my @newbusse = @busse ;

while (check(($linie*$runde),\@newbusse) == 0) {
      $runde++ ;
      @newbusse = @busse }

print $linie*$runde ;

exit 0 ;




sub check {
    my $zeit = shift ;
    my $bussptr = shift ;

    my $is = 1 ;
    my $checkval = '' ;
    while (($is == 1) && ($checkval = shift (@$bussptr))) {
          my ($adtime,$linie) = split /;/, $checkval ;
          $zeit -= $adtime ;
          if ($adtime % $linie != 0) {
            $is = 0 }
    }
    return $is } 

