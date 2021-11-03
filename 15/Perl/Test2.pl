#!/usr/bin/perl

use strict ;
use warnings ;

my $params = shift ;
$params =~ s/ //g ;

my @paramvalues = split /,/,$params ;

my @valueline = () ;
my $lastvalue = -1 ;
my %lastvaluehash = () ;
my $prevval = 0 ;
my $currval = 0 ;

my $place = 0 ;

for my $x (@paramvalues) {
    $lastvaluehash{$lastvalue}= $place ;
    print "Set $lastvalue = $place \n" ;
    $place++ ;
    $lastvalue = $x ;
    push @valueline , $x ;
    print "$place : $x \n" }
    
while ($place < 30000001) {
    if (exists $lastvaluehash{$lastvalue} ) {
        $currval = $place - $lastvaluehash{$lastvalue} }
    else {
        $currval = 0 }
    push @valueline , $currval ;
    if ($place > 29999999 ) {
    print "$place : $lastvalue \n" }
    $lastvaluehash{$lastvalue} = $place ;
    $place++ ;
    $lastvalue = $currval }
    
    
        
