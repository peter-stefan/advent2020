#!/usr/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


open IN , "../daten" ;

my $mask ;
my %hash = () ;

while (my $line = <IN>) {
      chomp $line ;
      if    ($line =~ m/^mask = (\w+)$/) {
         $mask = $1 }
      elsif ($line =~ m/^mem.(\d+). = (\d+)$/) {
         addEntry (\%hash,$mask,$1,$2) }
}

my $sum = 0 ;
for my $adr (sort keys %hash) {
    $sum += $hash{$adr} }
    
print $sum ;

exit 0 ;

sub addEntry {
    my $hashptr = shift ;
    my $mask    = shift ;
    my $adr     = shift ;
    my $value   = shift ;
    
    my $strval = valToBinString ($value) ;
    my $result = stringToValue ( maskValue ($mask, $strval ) );
    
    $hashptr->{$adr} = $result ;

    }

sub maskValue {
    my $mask  = shift ;
    my $value = shift ;
    my $result = '' ;
    
    while ($mask ne "") {
       my $maskdigit = substr ($mask,0,1) ;
       $mask = substr ($mask,1) ;
       my $valuedigit = substr ($value,0,1) ;
       $value = substr ($value,1) ;
       
       if ($maskdigit eq '0' || $maskdigit eq '1') {
           $result = $result.$maskdigit ; }
       else {
           $result = $result.$valuedigit }
    }
    
    return $result }
       
    
sub stringToValue {
    my $string = shift ;
    
    my $value = 0 ;
    
    while ($string ne "") {
       my $digit = substr($string,0,1) ;
       $string = substr($string,1) ;
       $value  = ($value * 2) + $digit }
       
    return $value }
       
sub valToBinString {
    my $value = shift ;
    my $string = '' ;
    
    for my $digit ( 1 .. 36 ) {
        my $rest = $value % 2 ;
        $string = $rest.$string ; 
        $value = $value / 2 }
        
    return $string }
