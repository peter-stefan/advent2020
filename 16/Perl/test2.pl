#!/usr/bin/perl

use strict ;
use warnings ;


my %legalvalues = () ;
my @legaltickets = () ;
my @ticketfields = () ;
my $resultarray = () ; # Each field with columnnumber 
my @myticketvals = () ;
my %hits = () ;

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
      $line =~ m/^(.+): (\d+)\-(\d+) or (\d+)\-(\d+)$/ ;
      my ($field,$from1,$to1,$from2,$to2) = ($1,$2,$3,$4,$5) ;
      fillvalues (\%legalvalues,$from1,$to1,$from2,$to2) ;
      push @ticketfields , $line ;
      print "$field\n" ;
      $hits{$field} = '' }
   elsif ($stage == 1) {
      push @legaltickets, $line ;
      @myticketvals = split /,/, $line }
   elsif ($stage == 2) {
      $error_rate += check_ticket (\%legalvalues,\@legaltickets,$line) }
}

print $error_rate."\n" ;

for my $line (@legaltickets) {
    linkticketfields (\%hits,\@ticketfields,$line) }
    
my @deplist = evaluateHits (\%hits) ;    

my $endval = 1 ;
for my $singleplace (@deplist) {
    $endval *= $myticketvals[$singleplace] }
    
print $endval."\n" ;

exit 0 ;


# fills all legal numbers in hash with 1
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
    my $legalvaluesptr  = shift ;
    my $legalticketsptr = shift ;
    my $line            = shift ;
    
    my $error_rate = 0 ;
    my @ticket_values = split /,/ , $line ;
    
    for my $value (@ticket_values) {
        unless (exists $legalvaluesptr->{$value}) {
           $error_rate += $value }
    }

    if ($error_rate == 0) {
       push @$legalticketsptr , $line }
       
    return $error_rate }

sub linkticketfields {
    my $hitsptr         = shift ;
    my $ticketfieldsptr = shift ;
    my $line            = shift ;
    
    my $place = 0 ;
    my @values = split /,/,$line ;
    for my $value (@values) {
        $place++ ;
    
        for my $field (@$ticketfieldsptr) {
            $field =~ m/^(.+): (\d+)\-(\d+) or (\d+)\-(\d+)$/ ;
            my ($field,$from1,$to1,$from2,$to2) = ($1,$2,$3,$4,$5) ;
            
            if (($value >= $from1 && $value <= $to1 )
                ||
                ($value >= $from2 && $value <= $to2 ) ) {
                $hitsptr->{$field} .= ",$place" }
        }
    }
}

sub evaluateHits {
    my $hitsptr = shift ;
    
    my %counterlist = () ;
    my %columnfield = () ;
    my $cfptr = \%columnfield ;
    my %fieldcolumn = () ;
    my $fcptr = \%fieldcolumn ;
    my @deplist = () ;
    
    for my $field ( keys %$hitsptr ) {
        my $counter = 0 ;
        
        my %resulthash = () ;
        my %result2hash = () ;
        
        my @hits = split /,/,$hitsptr->{$field} ;
        
        for my $column (@hits) {
            if (exists $resulthash{$column}) {
               $resulthash{$column} = $resulthash{$column} + 1}
            else {
               $resulthash{$column} = 1 }
        }
        
        for my $column (sort keys %resulthash) {
            if ($resulthash{$column} > 190 ) {
            $fcptr->{$field}->{$column} = 1 ;
            $cfptr->{$column}->{$field} = 1 ;
            $counter++ ;}
        }
        $counterlist{$counter} = $field ;    
    }
    
    for my $counter (1..20) {
        my $field = $counterlist{$counter} ;
        
        my $fieldptr = $fcptr->{$field} ;
        
        my ($column) = keys (%$fieldptr) ;
        
        print "$field:$column\n" ;
        if ($field =~ /departure/) {
           push @deplist , $column-1 }
        
        my $columnptr = $cfptr->{$column} ;
        for my $delfields (keys %$columnptr) {
            delete $fcptr->{$delfields}->{$column} }
    }
    
    return @deplist }
    
