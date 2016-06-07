#! /usr/bin/env perl

use v5.10;
use warnings;
use strict;
use OpusVL::WebsiteAdmin;
use File::Spec::Functions qw/catfile/;
use File::Basename qw/dirname/;

my $options = get_options();

my $site_name = $options->{site};

my @site = OpusVL::WebsiteAdmin->model('CMS::Site')->search({name => $site_name});

if (@site == 0) {
    say STDERR "Error: Site not found: $site_name";
    exit(3);
}
if (@site > 1) {
    say STDERR "Error: Too many matches for site: $site_name";
    exit(3);
}

my $site = $site[0];


my $append_html = sub { shift . '.html' };
dump_rs(recordset => scalar $site->elements, outdir => 'elements', alterslug => $append_html);
dump_rs(recordset => scalar $site->assets, outdir => 'assets');
dump_rs(recordset => scalar $site->templates, outdir => 'templates', alterslug => $append_html, getslug => 'name');

sub dump_rs {
    my %params = @_;
    my $rs = $params{recordset};
    my $dir = $params{outdir};
    my $alterslug = $params{alterslug} // sub { shift };
    my $getslug = $params{getslug} // 'slug';

    system qw(mkdir -p), $dir;
    for ($rs->all) {
        my $slug = $_->$getslug;
        my $content = $_->content;
        my $filename = catfile($dir, $slug->$alterslug);
        use autodie;
        open my $file, '>', $filename;
        print $file $content;
        close $file;
    }
}

sub get_options {
    use File::Basename qw(basename);
    use Getopt::Long;
    use Pod::Usage;

    my $prog = basename($0);  # can be used in error messages

    my $options = {
        help => 0,
        man => 0,
        site => undef,
    };

    Getopt::Long::Configure(qw{gnu_getopt});
    my $parsed_ok = GetOptions(
        'h|help'    =>  \$options->{help},
        'man'       =>  \$options->{man},
        'site|s=s'  =>  \$options->{site},
    );

    pod2usage(-exitval => 2) unless $parsed_ok;
    pod2usage(-exitval => 2) unless $options->{site};

    # Note -output defaults to *STDOUT if -exitval is 0 or 1.
    # See the documentation for Pod::Usage under DESCRIPTION.
    pod2usage(-exitval => 1, -verbose => 1) if $options->{help};
    pod2usage(-exitval => 1, -verbose => 2) if $options->{man};

    # Process remaining arguments from @ARGV here, adding results
    # to $options.

    return $options;
}

__END__

=head1 NAME

opusvl_websiteadmin_dump_site.pl - extract site into directory structure

=head1 SYNOPSIS

opusvl_websiteadmin_dump_site.pl [options] -s I<site>

 Options:
    -h, --help              brief help message
    --man                   full documentation
    --site site, -s site    specify the site name (required)

=head1 OPTIONS

=over 8

=item B<--help> or B<-h>

Print a brief help message and exit.

=item B<--man>

Print the manual page and exit.

=back

=head1 DESCRIPTION

B<opusvl_websiteadmin_dump_site.pl> will dump the site named I<site> into your current working directory.


The structure is as follows:

=over 8

=item elements

A directory containing the elements defined in the given site.  e.g.

    elements/order.html

Note that .html is added to the end of all element names.

=item templates

A directory containing the templates in the given site, e.g.

    templates/thetemplate.html

Note that .html is added to the end of all template names

=item assets

A directory containing the assets defined in the given site.  e.g.

    assets/bootstrap-theme.css
    assets/tux.jpg

=back

=cut
