#!/usr/bin/perl

use strict ;
use warnings ;

my $params = shift ;
$params =~ s/ //g ;

my @paramvalues = split /,/,$params ;

my @valueline = () ;
my $lastvalue = 0 ;
my %lastvaluehash = () ;
my $prevval = 0 ;
my $currval = 0 ;

my $place = 0 ;

for my $x (@paramvalues) {
    $lastvaluehash[$x]
    $place++ ;
    $lastvalue = $x ;
    push @valueline , $x ;
    $lastvaluehash[$x]= $place }
    
while ($place < 2021) {
    if (exists $lastvaluehash{$lastvalue} ) {
        $currval = $place - $lastvaluehash{$lastvalue} }
    else {
        $currval = 0 }
    push @valueline , $currval ;
    $lastvaluehash{$lastvalue} = $place ;
    $place++ ;
    
        
