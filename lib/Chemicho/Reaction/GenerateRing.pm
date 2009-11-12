package Chemicho::Reaction::GenerateRing;

use warnings;
use strict;
use Chemistry::File::SMARTS;

=head1 NAME

Chemicho::GenerateRing - Generate Ring Structure

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Generate Ring Structure

Perhaps a little code snippet.

    use Chemicho::GenerateRing;
    my $cvt = Chemicho::GenerateRing->new();
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
    my $SMARTS = '[!R&C!H0]CCCC[!R&C!H0]';
    $self->{pattern} = Chemistry::Pattern->parse($SMARTS, format => 'smarts');
    bless $self, $class;
}

=head2 react

=cut

sub react {
    my ($self,$react)    = @_;
 
    # random pattern selection using { if $count * rand() < 1.0; } 
    my $count=0;
    my (@nfg,@nbd);
    while ($self->{pattern}->match($react)){
	$count++;
	@nfg = $self->{pattern}->atom_map if $count * rand() < 1.0 ;
    }

    return undef unless @nfg; # if not match;
    
    $react->new_bond(atoms => [$nfg[0],$nfg[5]], order => '1');
    
    my $h_count0 = $nfg[0]->implicit_hydrogens();
    $h_count0 = $h_count0 - 1;
    $nfg[0]->implicit_hydrogens($h_count0);
    
    my $h_count1 = $nfg[5]->implicit_hydrogens();
    $h_count1 = $h_count1 - 1;
    $nfg[5]->implicit_hydrogens($h_count1);

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
