package OpusVL::WebsiteAdmin;

use strict;
use warnings;
use OpusVL::WebsiteAdmin::Builder;

our $VERSION = "0.11";

my $builder = OpusVL::WebsiteAdmin::Builder->new(
    appname => __PACKAGE__,
    version => $VERSION,
);

$builder->bootstrap;

1;

=head1 NAME

OpusVL::WebsiteAdmin - CMS Admin Site

=head1 DESCRIPTION

=head1 METHODS

=head1 ATTRIBUTES


=head1 LICENSE AND COPYRIGHT

Copyright 2015 OpusVL.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

If you require assistance, support, or further development of this software, please contact OpusVL using the details below:

=over 4

=item *

Telephone: +44 (0)1788 298 410

=item *

Email: community@opusvl.com

=item *

Web: L<http://opusvl.com>

=back

=cut
