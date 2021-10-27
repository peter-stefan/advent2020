#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


my $ship ='90;0;0' ;


open IN , "daten" ;

while (my $line = <IN>) {
    chomp $line ;
    my $new_ship = get_new_position ($ship,$line) ;
    print "$ship;$line;$new_ship\n" ;
    $ship = $new_ship }




sub get_new_position {
    my $ship    = shift ;
    my $request = shift ;
 
    my ($heading,$pose,$posn) = split /;/ , $ship ;

    $request =~ m/(\w)(\d+)/ ;
    my ($cmd,$value) = ($1,$2) ;

    if    ($cmd eq 'L') { 
       $heading -= $value ;
       if ($heading < 0) { $heading += 360 } }
    elsif ($cmd eq 'R') {
       $heading += $value ;
       if ($heading >= 360) { $heading -= 360 } }
    elsif ($cmd eq 'F') {
       if    ($heading ==   0) { $posn += $value }
       elsif ($heading ==  90) { $pose += $value }
       elsif ($heading == 180) { $posn -= $value }
       elsif ($heading == 270) { $pose -= $value } }
    elsif ($cmd eq 'N') { $posn += $value }
    elsif ($cmd eq 'E') { $pose += $value }
    elsif ($cmd eq 'S') { $posn -= $value }
    elsif ($cmd eq 'W') { $pose -= $value }

    return "$heading;$pose;$posn" }



