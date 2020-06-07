package ColorTheme::Test::Static;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
use parent 'ColorThemeBase::Static';
use Color::RGB::Util 'rand_rgb_color';

our %THEME = (
    v => 2,
    summary => 'A simple color theme',
    colors => {
        color1 => 'ff0000',
        color2 => '00ff00',
        color3 => '0000ff',
        color4 => {fg=>'000000', bg=>'ffffff'},
        color5 => sub {
            +{
                summary => 'A random foreground color',
                fg => rand_rgb_color(),
            };
        },
    },
);

1;
# ABSTRACT: A color theme with static list of colors
