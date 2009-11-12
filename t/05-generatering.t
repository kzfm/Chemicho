#!perl -T

use Test::More tests => 6;
use Chemistry::File::SMILES;
#use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::GenerateRing' );
}

#diag( "Testing Chemicho::Reaction::GenerateRing $Chemicho::Reaction::GenerateRing::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('CCCCCC chain_to_ring', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::GenerateRing->new();
isa_ok($cvtr,'Chemicho::Reaction::GenerateRing','GenerateRing instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"C1CCCCC1\tchain_to_ring");

