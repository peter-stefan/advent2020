#!/usr/bin/perl

use strict ;
use warnings ;


my %legalvalues = () ;
my $stage = 0 ;
my $error_rate = 0 ;

open IN , "../data" ;

while (my $line = <IN>) {
   chomp $line ;
   if ($line eq '') {
      next }
   if ($line eq 'your ticket:') {
      $stage = 1 }
   elsif ($line eq 'nearby tickets:') {
      $stage = 2 }
   elsif ($stage == 0) {
      $line =~ m/(\w+): (\d+)\-(\d+) or (\d+)\-(\d+)/ ;
      my ($field,$from1,$to1,$from2,$to2) = ($1,$2,$3,$4,$5) ;
      fillvalues (\%legalvalues,$from1,$to1,$from2,$to2) }
   elsif ($stage == 1) {
      my $validticket = check_ticket (\%legalvalues,$line) }
   elsif ($stage == 2) {
      $error_rate += check_ticket (\%legalvalues,$line) }
}

print $error_rate."\n" ;
exit 0 ;


sub fillvalues {
    my $legalvaluesptr = shift ;
    my $from1          = shift ;
    my $to1            = shift ;
    my $from2          = shift ;
    my $to2            = shift ;
    
    for my $value ($from1 .. $to1) {
        $legalvaluesptr->{$value} = 1 }
    for my $value ($from2 .. $to2) {
        $legalvaluesptr->{$value} = 1 }        
    }

sub check_ticket {
    my $legalvaluesptr = shift ;
    my $line           = shift ;
    
    my $error_rate = 0 ;
    my @ticket_values = split /,/ , $line ;
    
    for my $value (@ticket_values) {
        unless (exists $legalvaluesptr->{$value}) {
           $error_rate += $value }
    }
    
    return $error_rate }
