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
    my @list = sort keys %{ $self->{colors} };
    wantarray ? @list : \@list;
}

sub get_color {
    my ($self, $name, $args) = @_;

    my $c = $self->{colors}{$name};
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
# ABSTRACT: Base class for color theme modules with static list of items (from object's colors key)

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

Much like L<ColorThemeBase::Static::FromStructColors>, this base class also gets
the list of items from a data structure, in this case the object's C<colors> key
which is assumed to be a mapping of item names and color codes, much like the
C<colors> property of the color theme structure. It is expected that the
subclass sets the value of this key during initialization.


=head1 SEE ALSO

L<ColorThemeBase::Static::FromStructColors>
