package ColorThemeBase::Base;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
#use warnings;
use parent 'ColorThemeBase::Constructor';

sub get_struct {
    my $self = shift;
    \%{"$self->{orig_class}::THEME"};
}

sub get_args {
    my $self = shift;
    $self->{args};
}

1;
# ABSTRACT: A suitable base class for all ColorTheme::* modules

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION
