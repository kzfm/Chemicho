#!perl -T

use Test::More tests => 5;
use Chemistry::File::SMILES;
use Data::Dumper;
#use Data::Dumper;

BEGIN {
	use_ok( 'Chemicho' );
}

#diag( "Testing Chemicho::GenerateRing $Chemicho::GenerateRing::VERSION, Perl $], $^X" );


my $mol = Chemistry::Mol->parse('OC(=O)c1ccc(CC(CC=N)C=C)cc1 test', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','parse smiles nok');

my $chemicho = Chemicho->new();
isa_ok($chemicho,'Chemicho','Chemicho instance');

can_ok($chemicho,'load');

$chemicho->load('t/test.yaml');
#warn Dumper($chemicho->{cvtrs});

can_ok($chemicho,'mutate');

#my $prod = $chemicho->mutate($mol);
#isa_ok($prod,'Chemistry::Mol','Mutate nok');

#warn $prod->print(format => 'smiles', unique => 1, name => 1);

#my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
#is($react_smi,"C1CCCCC1\tchain_to_ring");

