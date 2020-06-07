package ColorThemeBasic::Static;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
#use warnings;

sub new {
    my $class = shift;

    # check that %THEME exists
    my $theme_hash = \%{"$class\::THEME"};
    unless (defined $theme->{v}) {
        die "Class $class does not define \%THEME with 'v' key";
    }
    unless ($theme->{v} == 2) {
        die "\%$class\::THEME's v is $theme->{v}, I only support v=2";
    }

    # check for known and required arguments
    my %args = @_;
    {
        my $args_spec = $theme_hash->{args};
        last unless $args_spec;
        for my $arg_name (keys %$args_spec) {
            die "Unknown argument '$arg_name'" unless $args_spec->{$arg_name};
        }
        for my $arg_name (keys %$args_spec) {
            die "Missing required parameter '$param_name'"
                if $args_spec->{$arg_name}{req} && !exists($args{$arg_name});
            # apply default
            $args{$arg_name} = $args_spec->{$arg_name}{default}
                if !defined($args{$arg_name}) &&
                exists $args_spec->{$arg_name}{default};
        }
    }

    bless {
        args => \%args,

        # we store this because applying roles to object will rebless the object
        # into some other package.
        orig_class => $class,
    }, $class;
}

sub get_color_list {
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
