#!perl -T

use Test::More tests => 7;
use Chemistry::File::SMILES;
use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::AddCarbon' );
}

#diag( "Testing Chemicho::Reaction::AddCarbon $Chemicho::Reaction::AddCarbon::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('C#CC(C#N)C(C=O)CN=O test', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::AddCarbon->new();
isa_ok($cvtr,'Chemicho::Reaction::AddCarbon',' Addcarbon instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');


my $mol_2 = Chemistry::Mol->parse('O=O failtest', format => 'smiles');
$react = $cvtr->react($mol_2);
is($react,undef,'react nok');

my $mol_3 = Chemistry::Mol->parse('CO failtest', format => 'smiles');
$react = $cvtr->react($mol_3);
my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"CCO\tfailtest");
