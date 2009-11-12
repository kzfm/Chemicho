#!perl -T

use Test::More tests => 7;
use Chemistry::File::SMILES;
#use Data::Dumper;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
	use_ok( 'Chemicho::Reaction::Thiophenize' );
}

#diag( "Testing Chemicho::Reaction::DeAromatize $Chemicho::Reaction::Stericalize::VERSION, Perl $], $^X" );

my $cvtr = Chemicho::Reaction::Thiophenize->new();
isa_ok($cvtr,'Chemicho::Reaction::Thiophenize','Thiophenize instance');

can_ok($cvtr,'react');


{
my $mol = Chemistry::Mol->parse('c1ccccc1 benzene', format => 'smiles');
isa_ok($mol,'Chemistry::Mol','benzene');
aromatize_mol($mol);

my $react = $cvtr->react($mol);
isa_ok($react,'Chemistry::Mol','react');

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
like($react_smi,qr/s1cccc1/,"thiophene");
}

{
my $mol = Chemistry::Mol->parse('c1c(Cl)c(F)c(Br)cc1 benzene', format => 'smiles');
aromatize_mol($mol);

my $react = $cvtr->react($mol);

my $react_smi =  $react->print(format => 'smiles', unique => 1, name => 1);
like($react_smi,qr/s/,"thiophene");
}
