#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Chemicho' );
}

diag( "Testing Chemicho $Chemicho::VERSION, Perl $], $^X" );
