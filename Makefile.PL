
use ExtUtils::MakeMaker;

    WriteMakefile(
        'NAME'          => 'Games::NIM',
        'VERSION_FROM'  => 'lib/Games/NIM.pm', # finds $VERSION
#        dist           => { COMPRESS => "gzip", SUFFIX => "gz" },
#        clean          => { FILES => '*.bak *.old mibs/*.dump ' .
#                                         'lib/*/*~ lib/*/*/*~' },    
#	'PREREQ_PM'     => {
#                 Module::Name => minimum.version.number,
#                 Module::Name => 3.21,
#                 ...
#         },

    );


