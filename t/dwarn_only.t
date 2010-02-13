use strict;
use warnings FATAL => 'all';
use Test::More qw(no_plan);

use Devel::Dwarn qw(Dwarn_only DwarnS_only);

warn Dwarn_only { $_[0] } qw(one two three);

warn DwarnS_only { $_->[0] } [ qw(one two three) ];
