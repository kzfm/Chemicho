#!perl -T

use Test::More tests => 6;
use Chemistry::File::SMILES;
#use Data::Dumper;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
	use_ok( 'Chemicho::Reaction::Hydroxylation' );
}

#diag( "Testing Chemicho::Reaction::Hydroxylation $Chemicho::Reaction::Stericalize::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('Cc1ccccc1 metbenzene', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','metbenzene');
aromatize_mol($mol);

my $cvtr = Chemicho::Reaction::Hydroxylation->new();
isa_ok($cvtr,'Chemicho::Reaction::Hydroxylation','DeAromatze instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"Oc1ccccc1\tmetbenzene");

