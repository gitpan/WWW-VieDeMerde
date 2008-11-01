#!perl -T

use Test::More;
use WWW::VieDeMerde;

BEGIN { my $plan = 0; }
plan tests => $plan;

my $vdm = WWW::VieDeMerde->new();


############################################################
# last, page
BEGIN { $plan += 4; }
is($vdm->page(), 15, "page donne des listes de 15 vdms");
is($vdm->last(), 15, "last() donne des listes de 15 vdms");
is($vdm->page(3), 15, "page marche aussi avec un numéro de page");
is($vdm->page(10000), 0, "rien sur la page 100000");

############################################################
# random
BEGIN { $plan += 1; }
my $r = $vdm->random();
ok($r->isa('WWW::VieDeMerde::Message'), "random renvoie une vdm");


############################################################
# flop, top
BEGIN { $plan += 6; }
is($vdm->top(), 15, "top donne des listes de 15 vdms");

# échoue juste après minuit, quand personne n'a encore voté
# aucune idée de comment exprimer ça avec Test::More
#is($vdm->top_jour(), 15, "top_jour donne des listes de 15 vdms");

is($vdm->top_semaine(), 15, "top_semaine donne des listes de 15 vdms");
is($vdm->top_mois(), 15, "top_mois donne des listes de 15 vdms");
is($vdm->flop(), 15, "flop donne des listes de 15 vdms");

# pareil que pour top_jour
#is($vdm->flop_jour(), 15, "flop_jour donne des listes de 15 vdms");

is($vdm->flop_semaine(), 15, "flop_semaine donne des listes de 15 vdms");
is($vdm->flop_mois(), 15, "flop_mois donne des listes de 15 vdms");

############################################################
# cat
BEGIN { $plan += 6; }
for (qw/amour argent travail sante sexe inclassable/) {
    is($vdm->cat($_), 15, "cat($_) renvoie 15 vdm");
}

############################################################
TODO: {
    local $TODO = "Not implemented";
}

