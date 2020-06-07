package ColorTheme::Test::Simple;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
our @ISA = qw(ColorThemeBase::Static);

our %THEME = (
    v => 2,
    summary => 'A simple color theme',
    colors => {
        color1 => 'ff0000',
        color2 => '00ff00',
        color3 => '00ff00',
        color4 => {fg=>'000000', bg=>'ffffff'},
    },
);

1;
# ABSTRACT: A simple color theme
