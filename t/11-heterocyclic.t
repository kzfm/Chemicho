#!perl -T

use Test::More tests => 6;
use Chemistry::File::SMILES;
#use Data::Dumper;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
	use_ok( 'Chemicho::Reaction::HeteroCyclization' );
}

#diag( "Testing Chemicho::Reaction::DeAromatize $Chemicho::Reaction::Stericalize::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('c1ccccc1 benzene', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','benzene');
aromatize_mol($mol);

my $cvtr = Chemicho::Reaction::HeteroCyclization->new();
isa_ok($cvtr,'Chemicho::Reaction::HeteroCyclization','Heterocyclization instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
like($react_smi,qr/c1?nc1?/,"heterocyclic");

