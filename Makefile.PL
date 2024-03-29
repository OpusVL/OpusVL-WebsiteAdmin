#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'OpusVL-WebsiteAdmin';
all_from 'lib/OpusVL/WebsiteAdmin.pm';
license 'perl';

requires 'OpusVL::Website';
requires 'Catalyst::Runtime' => '5.90002';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::Session::Store::Cache';
requires 'Catalyst::Authentication::Credential::HTTP';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'OpusVL::AppKit';
requires 'OpusVL::AppKitX::CMS';
requires 'OpusVL::Website';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
resources (
    repository => {
        url => 'ssh://git/srv/git/OpusVL-WebsiteAdmin',
        type => 'git',
    },
);

WriteAll;
