#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @programm = () ;

while (my $line = <IN>) {
   chomp $line ;
   push @programm , '0;'.$line }
push @programm , '1;fin +0' ;
close IN ;

my $numline = scalar @programm ;
push @programm , '1;fin +0' ;

print "$numline\n" ;

my $startline = 0 ;
while ($startline < $numline) {
    my @newprog = @programm ;
    my $cmd = substr($newprog[$startline],2,3) ;
    while($cmd ne 'nop' && $cmd ne 'jmp' && $startline < $numline ) {
       $startline++ ;
       $cmd = substr($newprog[$startline],2,3) }
    if    ($cmd eq 'nop') {
       $newprog[$startline]=substr($newprog[$startline],2,3,'jmp')}
    elsif ($cmd eq 'jmp') {
       $newprog[$startline]=substr($newprog[$startline],2,3,'nop')}
    $startline++ ;
    check (\@newprog) } 
    

sub check {
    my $prgptr = shift ;
    my @programm = @$prgptr ;
    my $lfd = 0 ;
    my $acc = 0 ;
    while (my $line = $programm[$lfd]) {
      last if (substr($line,0,1) eq '1') ;

      $programm[$lfd]=substr($programm[$lfd],0,1,'1') ;

      $line =~ m/^.;(...) (.)(\d+)$/ ;
      my ($cmd,$sign,$value) = ($1,$2,$3) ;

      if    ($cmd eq 'acc') {
         if ($sign eq '+') {
            $acc += $value }
         else              {
            $acc -= $value }
         $lfd++ }
      elsif ($cmd eq 'jmp') {
         if ($sign eq '+') {
            $lfd += $value }
         else              {
            $lfd -= $value }
      }
      else {
         $lfd++ }
    }
    print "Acc:$acc;Lfd:$lfd\n" ;

    return }


