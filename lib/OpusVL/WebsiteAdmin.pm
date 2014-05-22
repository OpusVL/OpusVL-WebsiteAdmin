package OpusVL::WebsiteAdmin;

use strict;
use warnings;
use OpusVL::WebsiteAdmin::Builder;

our $VERSION = "0.06";

my $builder = OpusVL::WebsiteAdmin::Builder->new(
    appname => __PACKAGE__,
    version => $VERSION,
);

$builder->bootstrap;

1;
