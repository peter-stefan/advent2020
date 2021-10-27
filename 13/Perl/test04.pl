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



for my $newbus (@busse) {
    print "$linie;$newbus\n" ;
    $linie = synchro($linie,$newbus) }


print $linie."\n" ;

exit 0 ;

sub synchro {
    my $linie1 = shift ;
    my $bus2   = shift ;
    my ($adtime,$linie2) = split /;/, $bus2 ;

    my $counter = 1 ;
    while (nottogether($counter,$linie,$adtime,$linie2) ) {
       $counter++ }
    print $counter."\n" ;
    return ($counter*$linie1) }

sub nottogether {
    my $counter = shift ;
    my $linie   = shift ;
    my $adtime  = shift ;
    my $linie2  = shift ;

    my $step = ($counter * $linie) + $adtime ;

    if (($step % $linie2) != 0) {
       return 1 }
    return 0 } 
