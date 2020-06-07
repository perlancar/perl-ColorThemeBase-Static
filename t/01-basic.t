#!perl

use strict;
use warnings;
use Test::More 0.98;

use ColorTheme::Test::Static;

my $ct = ColorTheme::Test::Static->new;
is_deeply([$ct->get_color_list]      , [qw/color1 color2 color3 color4 color5/]);
is_deeply(scalar($ct->get_color_list), [qw/color1 color2 color3 color4 color5/]);

is_deeply($ct->get_color('color1'), 'ff0000');
is_deeply($ct->get_color('color2'), '00ff00');
is_deeply($ct->get_color('color3'), '0000ff');
is_deeply($ct->get_color('color4'), {bg=>'ffffff', fg=>'000000'});
ok(ref($ct->get_color('color5')), 'HASH');
is_deeply([$ct->get_color('color99')], []);

done_testing;
