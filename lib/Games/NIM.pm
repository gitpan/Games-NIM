package Games::NIM;
use strict;
use Carp;
use vars qw($VERSION);

$VERSION="0.01";

my @game_types = qw (simple);


sub new {
    my $self = shift;
    my $class = ref($self) || $self;

    my %data = (type => 'simple',
		machines_turn => 0,
		groups => [20],            # default
		takes => undef,            # you can take any number
		);

    $data{groups} = [int (rand(10)+20)];   # more default

    bless(\%data, $class);
    return \%data;
}

sub k_rule {
    my $self = shift;
    if (@_==1) {
	$self->{takes} = [$_[0]];
    }
    return $self->{takes}[0];
}

sub takes {
    my $self = shift;

    if (@_) {
	$self->{takes} = \@_;
    }
    
    return @{$self->{takes}};
}
    
    
sub status {
    my $self = shift;
    if (@_) {
	$self->{groups} = \@_;
    }
    
    return @{$self->{groups}};
}

sub step {
    my $self = shift;
    
    if ($self->{type} eq 'simple') {
	if (@_ != 1) { croak "Invalid number of parameters"; }
	my $s = shift;
	if ($s > $self->{groups}[0]) { 
	    carp "Invalid step\n"; 
	    return $self->{groups}[0];
	}
	$self->{groups}[0] -= $s;
	return $self->{groups}[0];
    } else {
	croak "Invalid type!\n";
    }
    
}

sub machine_step {
    my $self = shift;

    if ($self->{groups}[0] == 1) {
	return $self->step(1);
    }
    my $s = 1 + int (rand ($self->{groups}[0]/2-1));
    return $self->step($s);
	
}

sub play {
    my $self = shift;

    my @status = $self->status;

    while (1) {
	my $step;

	foreach my $line ($self->status) {
	    print "x" x $line,  "  ($line)\n";
	}
	last unless ($status[0]);
    
	chomp($step = <STDIN>);
	#my ($row, $col) = split / /, $step;
	@status = $self->step($step);
	foreach my $line (@status) {
	    print "x" x $line,  "  ($line)\n";
	}
	last unless ($status[0]);


	print "Machines Step\n";
	@status = $self->machine_step;    
    }
    print "Finished\n";
}

1;

=pod

=head1 NAME

 NIM - mathematical games

=head1 SYNOPSYS

 use Games::NIM;

 $game = new Games::NIM;
 $game->play();

=head1 DESCRIPTION

 Currently you can only play on the command line with the built in interface.
 Send your feedback so I now how to improve.

=head1 RULES

 In all the games there are several groups of something, let's call them stones.
 There are 2 players who take away a few stones on every turn according to some rules.
 They always have to take away at leas one stone.
 The winner is eihter the one who takes the last stone, or the other player :) 
 depending on the game.

=over

=item 1 simple

There is one group of (n) stones.
There is a list of number
Each player can take 1,2, .. k stones at a time.
 
k is defined when we start the game.

The winner is who takes the last stone.

=item 2 not implemented yet

There is one group of (n) stones.

Each player can take a few stones at a time where the possible numbers
are listed at the beginning of the game.
   The list can contain any of the values between 1 and n
   E.g. it can be only 3 or   3 and 7, or ...

The winner is who takes the last stone.

Special cases are:
(k, k+1)
(1, k)
(k, q)

=item 3 not implemented yet

There are more groups, in each group there are a few stones.
Each player can can take either the same number from all groups or
any number from one group.
The winner who takes the last one

=item 4 not implemented yet

There are more groups
Any number from any number of groups, but the same number from each group.
The winner who takes the last one.

=item 5 not implemented yet: Chocolate eating

There is a chocolate of n*m cubes
Two people are eating the chocolate by pointing on one of the cubes 
  and eating everything to the right and below in the chocolate:
  e.g. inthe following case I pointed to the cube signed with an x
oooooo
oooxo
oooo
oo

result:

oooooo
ooo
ooo
oo


The game ends when there are no more chocolate
The winner is who remains without chocolate.
(The one who takes the last chocolate loses)

=back

=head1 AUTHORS

Gabor Szabo <gabor@tracert.com>

=head1 COPYRIGHT

The NIM module is Copyright (c) 2001 Gabor Szabo. Israel
All rights reserved.
 
You may distribute under the terms of either the GNU General Public
License or the Artistic License, as specified in the Perl README file.

=head1 ACKNOWLEDGEMENTS

 Dr. Zoltan Dienes for his book

=cut


# step - tell the system what was my step
#
# Games: 
# total number of stones ?
# a layout, how many stones in each group, - a list of numbers  - eg.: 1 3 7
#   what if there are more then 2 imensions ?
# a rectangular (or multidimensional) layout n*m can be also described as n, n, n, .. (m times)
# a ruleset: 
#   Who is the winner ? 
#       - the one who takes the last stone or 
#       - the one who has no more stones left ?

#   Number of groups
#
#   How can you take away from the groups: one from each group





