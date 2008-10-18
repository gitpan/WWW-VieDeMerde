#!perl -T

use Test::More tests => 2;
use WWW::VieDeMerde;

my $vdm = WWW::VieDeMerde->new();
ok(defined $vdm, "WWW::VieDeMerde->new() renvoie quelquechose");
ok($vdm->isa('WWW::VieDeMerde'), "qui a la bonne classe");

