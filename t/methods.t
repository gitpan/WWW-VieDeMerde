#!perl -T

use Test::More;
use WWW::VieDeMerde;

BEGIN { my $plan = 0; }
plan tests => $plan;

my $vdm = WWW::VieDeMerde->new();


############################################################
# last
BEGIN { $plan += 3; }
is($vdm->page(), 15, "page donne des listes de 15 vdms");
is($vdm->page(3), 15, "page marche aussi avec un numéro de page");
is($vdm->page(10000), 0, "rien sur la page 100000");

############################################################
# last
BEGIN { $plan += 1; }
is($vdm->last(), 15, "last() donne des listes de 15 vdms");

 TODO: {
     local $TODO = "Not implemented";
 }

