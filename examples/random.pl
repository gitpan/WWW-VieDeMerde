#! /usr/bin/perl -I../lib

use WWW::VieDeMerde;

my $vdm = WWW::VieDeMerde->new();

my $r = $vdm->random();
print $r->texte, "\n\n";

