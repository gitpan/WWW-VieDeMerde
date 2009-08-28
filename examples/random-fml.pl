#! /usr/bin/perl -I../lib

use WWW::VieDeMerde;

my $vdm = WWW::VieDeMerde->new(lang => 'en');

my $r = $vdm->random();
print $r->text, "\n";
print $r->id, "\n";

