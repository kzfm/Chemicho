#!perl -T

use Test::More tests => 6;
use Chemistry::File::SMILES;
#use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho::Reaction::Aromatize' );
}

#diag( "Testing Chemicho::Reaction::Halogenize $Chemicho::Reaction::Halogenize::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('C=CC=C arom', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $cvtr = Chemicho::Reaction::Aromatize->new();
isa_ok($cvtr,'Chemicho::Reaction::Aromatize','Aromatize instance');

can_ok($cvtr,'react');

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react nok');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
is($react_smi,"c1ccccc1\tarom");

