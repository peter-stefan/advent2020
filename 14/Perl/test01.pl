#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


open IN , "daten" ;

my $mask ;
while (my $line = <IN>) {
      chomp $line ;
      if    ($line =~ m/^mask = (\w+)$/) {
         $mask = $1 }
      elsif ($line =~ m/^mem.(\d+). = (\d+)$/) {
         addEntry (\%hash,$mask,$1,$2) }




my $zeit = <IN> ;
chomp $zeit ;

my $zeile = <IN> ;
chomp $zeile ;

close IN ;

my @linien = split /,/ , $zeile ;


my $maxzeit = 99999 ;
my $maxlinie = -1    ;

for my $linie (@linien) {
    next if ($linie eq 'x') ;
    my $wartezeit = wartezeit($zeit,$linie) ;
    print "$linie:$wartezeit\n" ;
    if ($wartezeit < $maxzeit) {
      $maxzeit = $wartezeit ;
      $maxlinie = $linie }
}




sub wartezeit {
    my $zeit  = shift ;
    my $linie = shift ;

    my $wartezeit = $linie - ( $zeit % $linie ) ;

    return $wartezeit }

