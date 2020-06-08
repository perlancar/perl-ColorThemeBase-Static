package ColorThemeBase::Static;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
#use warnings;

use parent 'ColorThemeBase::Constructor';

sub list_items {
    my $self = shift;

    my $theme_hash = \%{"$self->{orig_class}::THEME"};
    my @list = sort keys %{ $theme_hash->{colors} };
    wantarray ? @list : \@list;
}

sub get_color {
    my ($self, $name, $args) = @_;

    my $theme_hash = \%{"$self->{orig_class}::THEME"};

    my $c = $theme_hash->{colors}{$name};
    return unless defined $c;

    if (ref $c eq 'CODE') {
        my $c2 = $c->($self, $name, $args);
        if (ref $c2 eq 'CODE') {
            die "Color '$name' of theme $self->{orig_hash} returns coderef, ".
                "which after called still returns a coderef";
        }
        return $c2;
    }
    $c;
}

1;
# ABSTRACT: Base class for color theme modules with static list of colors

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This base class is for color theme modules that only have static color list,
i.e. all its colors are listed in the %THEME package variable, under the key
C<colors>.

Note that the color itself can be dynamic, e.g. return a coderef.
