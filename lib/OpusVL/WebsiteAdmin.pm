package OpusVL::WebsiteAdmin;

use strict;
use warnings;
use OpusVL::WebsiteAdmin::Builder;

our $VERSION = "0.07";

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

This software is licensed according to the "IP Assignment Schedule" provided with the development project.

=cut
