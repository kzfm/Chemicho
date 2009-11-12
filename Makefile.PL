use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Chemicho',
    AUTHOR              => 'Kazufumi Ohkawa <kerolinq@gmail.com>',
    VERSION_FROM        => 'lib/Chemicho.pm',
    ABSTRACT_FROM       => 'lib/Chemicho.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Chemicho-*' },
);
