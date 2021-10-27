#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;

open IN , 'daten' ;

my @programm = () ;

while (my $line = <IN>) {
   chomp $line ;
   push @programm , '0;'.$line }

my $lfd = 0 ;
my $acc = 0 ;
while (my $line = $programm[$lfd]) {
  last if (substr($line,0,1) eq '1') ;

  $programm[$lfd]=substr($programm[$lfd],0,1,'1') ;

  $line =~ m/^0;(...) (.)(\d+)$/ ;
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

print "Acc:$acc\n" ;
print "Lfd:$lfd\n" ;
close IN ;
