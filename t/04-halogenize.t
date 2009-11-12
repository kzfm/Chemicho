#!perl -T

use Test::More tests => 6;
use Chemistry::File::SMILES;
#use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::Halogenize' );
}

#diag( "Testing Chemicho::Reaction::Halogenize $Chemicho::Reaction::Halogenize::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('C(=O)C testmol', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::Halogenize->new();
isa_ok($cvtr,'Chemicho::Reaction::Halogenize','Halogenize instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
#is($react_smi,"ClC=O\tmet_to_Cl");
warn $react_smi;
like($react_smi,qr/[Cl|F|Br]/,"halogenize");
