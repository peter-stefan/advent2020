#!/opt/web/perl/current/bin/perl

use strict ;
use warnings ;
use Data::Dumper ;


my $SPACE = '.' ;
my $EMPTY = 'L' ;
my $USED  = '#' ;

my $hashptr ;

my ($height,$length) = create_field ($hashptr) ;
show_field ($hashptr,$height,$length) ;
my $oldseated = -1 ;
my $newseated = count_seated_all($hashptr,$height,$length) ; 

while ($newseated != $oldseated) {
   $oldseated = $newseated ;
   my $newptr = create_ng ($hashptr,$height,$length) ;
   show_field ($newptr,$height,$length) ; 
   $newseated = count_seated_all($newptr,$height,$length) ;       
   print "Seated: $newseated\n" ;
   $hashptr = $newptr }
      

sub count_seated_all {
    my $fieldptr = shift ;
    my $height   = shift ;
    my $length   = shift ;

    my $count = 0 ;

    for my $row (1..$height) {
        for my $col (1..$length) {
            my $char = $fieldptr->{$row}->{$col} ;
            if ($char eq $USED) {$count++}
        }
    }
    return $count}


sub show_field {
    my $fieldptr = shift ;
    my $height   = shift ;
    my $length   = shift ;

    for my $row (1..$height) {
        for my $col (1..$length) {
            print $fieldptr->{$row}->{$col} }
        print "\n" }

    return }

sub create_ng {
    my $oldfield = shift ;
    my $height   = shift ;
    my $length   = shift ;
    my %hash = () ;
    my $newfield = \%hash ;

    for my $row (1..$height) {
        for my $col (1..$length) {
            my $newval = check_place_ng ($oldfield,$row,$col) ;
            $newfield->{$row}->{$col} = $newval }
        $newfield->{$row}->{0}         = $EMPTY ;
        $newfield->{$row}->{$length+1} = $EMPTY }
     
    for my $col (0..$length+1) {
        $newfield->{        0}->{$col} = $EMPTY ;
        $newfield->{$height+1}->{$col} = $EMPTY }
    return $newfield  }

sub check_place_ng {
    my $fieldptr = shift ;
    my $row      = shift ;
    my $col      = shift ;

    my $curr   = $fieldptr->{$row}->{$col} ;
    my $seated = new_count_seated_around ($fieldptr,$row,$col) ;
    if    ($curr eq $SPACE)
          { return $SPACE }
    elsif (($curr eq $EMPTY) && $seated == 0)
          { return $USED  }
    elsif (($curr eq $USED)  && $seated > 4)
          { return $EMPTY }

    return $curr }

sub count_seated_around {
    my $fieldptr = shift ;
    my $row      = shift ;
    my $col      = shift ;

    my $numseated = 0 ;

    for my $ccol (($col-1)..($col+1)) {
        if ($fieldptr->{$row-1}->{$ccol} eq $USED) {$numseated++}
        if ($fieldptr->{$row+1}->{$ccol} eq $USED) {$numseated++}
    }
    if ($fieldptr->{$row}->{($col-1)} eq $USED) {$numseated++}
    if ($fieldptr->{$row}->{($col+1)} eq $USED) {$numseated++}

    return $numseated }

sub new_count_seated_around {
    my $fieldptr = shift ;
    my $row      = shift ;
    my $col      = shift ;

    my $numseated = 0 ;

    if (first_seat_in_sight($fieldptr,$row,$col,-1,-1) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col,-1, 0) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col,-1, 1) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col, 0,-1) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col, 0, 1) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col, 1,-1) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col, 1, 0) eq $USED) { $numseated++ }
    if (first_seat_in_sight($fieldptr,$row,$col, 1, 1) eq $USED) { $numseated++ }

    return $numseated }

sub first_seat_in_sight {
    my $fieldptr = shift ;
    my $row      = shift ;
    my $col      = shift ;
    my $rowp     = shift ;
    my $colp     = shift ;

    my $counter = 1 ;

    my $char = $fieldptr->{$row+($rowp*$counter)}->{$col+($colp*$counter)} ;
    while ($char eq $SPACE) {
       $counter++ ;
       $char = $fieldptr->{$row+($rowp*$counter)}->{$col+($colp*$counter)} }

    return $char }

sub create_field {
    my $fieldptr = shift ;

    my $linelength = 0 ;
    my $row = 0 ;

    open IN , 'daten' ;

    while (my $line = <IN>) {
       chomp $line ;
       $linelength = length ( $line ) ;
       $row++ ;
       for my $col (1..$linelength) {
           $hashptr->{$row}->{$col} = substr($line,($col-1),1) } ;
       $hashptr->{$row}->{0} = $SPACE ;
       $hashptr->{$row}->{$linelength+1} = $EMPTY }

    close IN ;

    for my $col (0..$linelength+1) {
           $hashptr->{0}->{$col} = $SPACE ;
           $hashptr->{$row+1}->{$col} = $EMPTY }
    return ($row,$linelength) }


