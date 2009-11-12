package Chemicho::Reaction::DeAromatize;

use warnings;
use strict;
use Chemistry::File::SMARTS;

=head1 NAME

Chemicho::DeAromatize - Decompose Aromatic Ring

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Decompose Aromatic Ring

Perhaps a little code snippet.

    use Chemicho::DeAromatize;
    my $cvt = Chemicho::DeAromatize->new();
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
    my $SMARTS = '[h1]:[h1]:c:c:c:c';
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
	if($count * rand() < 1.0){
	    @nfg = $self->{pattern}->atom_map; 
	    @nbd = $self->{pattern}->bond_map; 
	}
    }

#    warn "not matched" unless $count;
    return undef unless $count; # if not match;
    
    #aroma-CH delete
    $nfg[0]->delete;
    $nfg[1]->delete;
    
    #edit bond C=C-C=C
    $nbd[2]->order(2);
    $nbd[3]->order(1);
    $nbd[4]->order(2);

    #add Hydrogen
    my $h_count2 = $nfg[2]->implicit_hydrogens();
    $h_count2 = $h_count2 + 1;
    $nfg[2]->implicit_hydrogens($h_count2);
    
    my $h_count5 = $nfg[5]->implicit_hydrogens();
    $h_count5 = $h_count5 + 1;
    $nfg[5]->implicit_hydrogens($h_count5);
    
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
