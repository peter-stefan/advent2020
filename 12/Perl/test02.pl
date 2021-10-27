#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


my $ship ='90;0;0;10;1' ;


open IN , "daten" ;

while (my $line = <IN>) {
    chomp $line ;
    my $new_ship = get_new_position ($ship,$line) ;
    print "$ship;$line;$new_ship\n" ;
    $ship = $new_ship }




sub get_new_position {
    my $ship    = shift ;
    my $request = shift ;
 
    my ($heading,$pose,$posn,$wpe,$wpn) = split /;/ , $ship ;

    $request =~ m/(\w)(\d+)/ ;
    my ($cmd,$value) = ($1,$2) ;

    if    (($cmd eq 'L' || $cmd eq 'R')  && $value == 180 ) { 
          $wpe = -$wpe ;
          $wpn = -$wpn }
    elsif (($cmd eq 'L' && $value ==  90)  ||
           ($cmd eq 'R' && $value == 270)) {
          my $nwpn = $wpe ;
          $wpe = -$wpn ;
          $wpn = $nwpn }
    elsif (($cmd eq 'R' && $value ==  90)  ||
           ($cmd eq 'L' && $value == 270)) {
          my $nwpn = -$wpe ;
          $wpe = $wpn ;
          $wpn = $nwpn }
    elsif ($cmd eq 'F') { 
       $pose += ($value*$wpe) ;
       $posn += ($value*$wpn) }
    elsif ($cmd eq 'N') { $wpn += $value }
    elsif ($cmd eq 'E') { $wpe += $value }
    elsif ($cmd eq 'S') { $wpn -= $value }
    elsif ($cmd eq 'W') { $wpe -= $value }

    return "$heading;$pose;$posn;$wpe;$wpn" }



