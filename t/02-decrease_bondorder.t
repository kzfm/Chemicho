#!perl -T

use Test::More tests => 8;
use Chemistry::File::SMILES;
use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::DecreaseBondOrder' );
}

#diag( "Testing Chemicho::Reaction::DecreaseBondOrder $Chemicho::Reaction::DecreaseBondOrder::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('C#C tri_to_double', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::DecreaseBondOrder->new();
isa_ok($cvtr,'Chemicho::Reaction::DecreaseBondOrder','DecreaseBondOrder instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"C=C\ttri_to_double");

my $mol2 = Chemistry::Mol->parse('C=O d_to_s', format => 'smiles');
my $react2 = $cvtr->react($mol2);
isa_ok($react2,'Chemistry::Mol','react nok');

my $react_smi2 =  $react2->print(format => 'smiles', unique => 1, name => 1);
is($react_smi2,"CO\td_to_s");
