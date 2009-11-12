package Chemicho;

use warnings;
use strict;
use YAML;
use Data::Dumper;
use UNIVERSAL::require;

=head1 NAME

Chemicho - Chemical Idea Generator

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

generate ideas of Chemical compound

Perhaps a little code snippet.

    use Chemicho;
    my $foo = Chemicho->new();
    

=head1 FUNCTIONS

=head2 new

=cut

sub new {
    my $class = shift;
     bless {}, $class;
}

=head2 load

load config file with YAML.

=cut

sub load {
    my($self, $stuff) = @_;
    my $config = YAML::LoadFile($stuff);
    $self->{Cycle} = $config->{Cycle} || 1;
    $self->{Generation} = $config->{Generation} || 1;
    $self->{Prefix} = $config->{Prefix} || "ProductNo";
    my $min_weight = 1;
    my $pow;
    $self->{cvtrs} = [];

    # Load Plugin Modules and search minimam weight
    for my $plg (@{$config->{Plugins}}){
	my $class = 'Chemicho::Reaction::' . $plg->{module};
	$class->require or die $@;
	$min_weight = $plg->{weight} if $plg->{weight} < $min_weight;
    }
    
    #calc Pow
    if ($min_weight < 1){
	$min_weight =~ /^0.(\d+)/;
	$pow = length($1);
    }
    
    # create object and push array
    for my $plg (@{$config->{Plugins}}){
	my $class = 'Chemicho::Reaction::' . $plg->{module};
	my $obj = $class->new();
	for(my $i = 0;$i < ($plg->{weight} * (10 ** $pow));$i++){
	    push @{$self->{cvtrs}}, $obj;
	}
    }

    return $self;
}

=head2 mutate

mutate Molcule

=cut

sub mutate {
    my($self, $react) = @_;
    my $index =  int(rand(@{$self->{cvtrs}}));
    my $cvtr = $self->{cvtrs}[$index];
    my $prod = $cvtr->react($react);
    return $prod;
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
