package Chemicho::Reaction::AddCarbon;

use warnings;
use strict;
use Chemistry::File::SMARTS;
=head1 NAME

Chemicho::AddCarbon - add CH3

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

add CH3 Carbon to Molecule

Perhaps a little code snippet.

    use Chemicho::AddCarbon;
    my $cvt = Chemicho::AddCarbon->new();
    $cvt->react($perlmol_object);

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 new

=cut

sub new {
    my $class    = shift;
    my $self = {};
    my $SMARTS = '[CH3,CH2,CH,c]';
    $self->{pattern} = Chemistry::Pattern->parse($SMARTS, format => 'smarts');
    bless $self, $class;
}

=head2 react

=cut

sub react {
    my ($self,$react)    = @_;
 
    # random pattern selection using { if $count * rand() < 1.0; } 
    my $count=0;
    my @frg;
    while ($self->{pattern}->match($react)){
	$count++;
	@frg = $self->{pattern}->atom_map if $count * rand() < 1.0;
    }

    return undef unless @frg; # if not match;

    my $c = $react->new_atom(symbol => "C");
    $react->new_bond(atoms => [$c, $frg[0]], order => '1');
    $c->implicit_hydrogens(3);
    
    my $h_count = $frg[0]->implicit_hydrogens();
    $h_count = $h_count - 1;
    $frg[0]->implicit_hydrogens($h_count);	
    return $react;
}

=head1 AUTHOR

Kazufumi Ohkawa, C<< <kerolinq at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-chemicho at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Chemicho>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Chemicho

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Chemicho>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Chemicho>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Chemicho>

=item * Search CPAN

L<http://search.cpan.org/dist/Chemicho>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006 Kazufumi Ohkawa, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Chemicho
