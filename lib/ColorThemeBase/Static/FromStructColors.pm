package ColorThemeBase::Static::FromStructColors;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
#use warnings;

use parent 'ColorThemeBase::Base';

sub list_items {
    my $self = shift;

    my $theme_hash = \%{"$self->{orig_class}::THEME"};
    my @list = sort keys %{ $theme_hash->{items} };
    wantarray ? @list : \@list;
}

sub get_item_color {
    my ($self, $name, $args) = @_;

    my $theme_hash = \%{"$self->{orig_class}::THEME"};

    my $c = $theme_hash->{items}{$name};
    return unless defined $c;

    if (ref $c eq 'CODE') {
        my $c2 = $c->($self, $name, $args);
        if (ref $c2 eq 'CODE') {
            die "Color '$name' of theme $self->{orig_class} returns coderef, ".
                "which after called still returns a coderef";
        }
        return $c2;
    }
    $c;
}

1;
# ABSTRACT: Base class for color theme modules with static list of items (from %THEME)

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This base class is for color theme modules that only have static list of items,
i.e. all from the %THEME package variable, under the key C<items>.

Note that the item color itself can be dynamic, e.g. return a coderef.


=head1 SEE ALSO

L<ColorThemeBase::Static::FromObjectColors>
