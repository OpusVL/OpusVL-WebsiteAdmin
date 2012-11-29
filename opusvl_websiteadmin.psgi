use strict;
use warnings;

use OpusVL::WebsiteAdmin;

my $app = OpusVL::WebsiteAdmin->apply_default_middlewares(OpusVL::WebsiteAdmin->psgi_app);
$app;

