package ColorThemeBase::Constructor;

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
    unless (defined $theme_hash->{v}) {
        die "Class $class does not define \%THEME with 'v' key";
    }
    unless ($theme_hash->{v} == 2) {
        die "\%$class\::THEME's v is $theme_hash->{v}, I only support v=2";
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
            die "Missing required argument '$arg_name'"
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

1;
# ABSTRACT: Provide new()

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION
