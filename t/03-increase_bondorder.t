#!perl -T

use Test::More tests => 8;
use Chemistry::File::SMILES;
use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::IncreaseBondOrder' );
}

#diag( "Testing Chemicho::Reaction::IncreaseBondOrder $Chemicho::Reaction::IncreaseBondOrder::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('CC s_to_d', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::IncreaseBondOrder->new();
isa_ok($cvtr,'Chemicho::Reaction::IncreaseBondOrder','IncreaseBondOrder instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"C=C\ts_to_d");

my $mol2 = Chemistry::Mol->parse('C=C d_to_t', format => 'smiles');
my $react2 = $cvtr->react($mol2);
isa_ok($react2,'Chemistry::Mol','react nok');

my $react_smi2 =  $react2->print(format => 'smiles', unique => 1, name => 1);
is($react_smi2,"C#C\td_to_t");
