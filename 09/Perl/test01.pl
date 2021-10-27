#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @list = () ;

while (my $line = <IN>) {
   chomp $line ;
   push @list , $line }
close IN ;

my $num = scalar @list ;
my $first = 0 ;

for my $i (0..($num-26)) {
 my @sublist = @list[$i..($i+26)] ;
 check_list (@sublist) }

sub check_list {
    my @sublist = @_ ;
    my $hit = 0 ;   
    my $check_value = @sublist[25] ;
#    print"==========================\n";
#    for my $k (0..25) {
#      my $value = $sublist[$k] ;
#      print "$k:$value\n" }
#    print "= = = = =\n" ;

    for my $i (0..23) {
        for my $j (1..24) {
            my ($val1,$val2) = ($sublist[$i],$sublist[$j]) ;
            my $res = $val1+$val2 ;
#            print "$val1 + $val2 = $res \n" ;
            if ($i != $j && $sublist[$i]+$sublist[$j] == $check_value ) {
               $hit = 1 }
        }
    }

   
    if ($hit == 0) {
       print "$check_value\n" }
}
