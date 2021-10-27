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
my $ges = 1 ;

my @sorted_list = sort{$a<=>$b} @list ;

for my $value (@sorted_list) {
    my $bef = '' ;
    my $string = '' ;
    my $sval = 0 ;
    if (exists $hash{$value+1}) {
       $string .= ($value+1) ;
       $bef = ';' ;
       $sval ++ }
    if (exists $hash{$value+2}) {
       $string .= $bef.($value+2) ;
       $bef = ';' ;
       $sval++ }
    if (exists $hash{$value+3}) {
       $string .= $bef.($value+3) ;
       $sval++ }
    $hash{$value} = $string ;
    }

sub anzahlDerWege {
    my $number = shift ;

    my $numwege = 0 ;
    my @wege = split (/;/,$hash{$number}) ;

    for my $weg (@wege) {
        $numwege += anzahlDerWege($weg) }

    return $numwege }

print anzahlDerWege(0) ;



printf ("'%30d'\n",$ges) ;
print $ges ;

