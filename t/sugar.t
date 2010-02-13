use strict;
use warnings;
use Data::Dumper::Concise::Sugar;

use Data::Dumper::Concise ();

use Test::More qw(no_plan);

my $warned_string;

BEGIN {
   $SIG{'__WARN__'} = sub {
      $warned_string = $_[0]
   }
}

DWARN: {
   my @foo = Dwarn 'warn', 'friend';
   is $warned_string,qq{"warn"\n"friend"\n}, 'Dwarn warns';

   ok eq_array(\@foo, ['warn','friend']), 'Dwarn passes through correctly';
}

DWARNS: {
   my $bar = DwarnS 'robot',2,3;
   is $warned_string,qq{"robot"\n}, 'DwarnS warns';
   is $bar, 'robot', 'DwarnS passes through correctly';
}

DWARNONLY: {
   my @foo = Dwarn_only { $_[0] } qw(one two three);
   is $warned_string,qq{"one"\n}, 'Dwarn_only warns requested data';

   ok eq_array(\@foo, [qw{one two three}]), 'Dwarn_only passes through correctly';
}

DWARNSONLY: {
   my $bar = DwarnS_only { $_->[0] } [ qw(one two three) ];
   is $warned_string,qq{"one"\n}, 'DwarnS_only warns requested data';

   ok $bar->[0] eq 'one' &&
      $bar->[1] eq 'two' &&
      $bar->[2] eq 'three' &&
      @{$bar} == 3, 'DwarnS_only passes through correctly';
}
