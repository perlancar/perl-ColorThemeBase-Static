package ColorTheme::Test::Dynamic;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;
use parent 'ColorThemeBase::Base';

our %THEME = (
    v => 2,
    summary => 'A dynamic color theme',
    dynamic => 1,
    args => {
        tone => {schema=>['str*', in=>['red','green']], req=>1},
        opt1 => {schema=>'str*', default=>'foo'},
        opt2 => {schema=>'str*'},
    },
    examples => [
        {
            summary => 'An red tone',
            args => { tone => 'red' },
        },
    ],
);

sub list_items {
    my $self = shift;

    my @list;
    if ($self->{tone} eq 'red') {
        @list = ('red1', 'red2', 'red3');
    } else {
        @list = ('green1', 'green2', 'green3');
    }
    wantarray ? @list : \@list;
}

sub get_item_color {
    my ($self, $name, $args) = @_;

    +{
        red1 => 'ff0000',
        red2 => 'cc0000',
        red3 => '992211',
        green1 => '00ff00',
        green2 => '00cc00',
        green3 => '15a008',
    }->{$name};
}

1;
# ABSTRACT:
