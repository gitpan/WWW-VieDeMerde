#!perl -T

use Test::More;
use WWW::VieDeMerde;
use WWW::VieDeMerde::Message;

use utf8;

my $one = <<EOF;
<?xml version="1.0" encoding="UTF-8"?>
<root><active_key>readonly</active_key><vdms><vdm
id="238320"><auteur>Belle</auteur><categorie>inclassable</categorie>
<date>2008-10-09T14:00:53+02:00</date><je_valide>3696</je_valide>
<bien_merite>5807</bien_merite><commentaires>82</commentaires>
<texte>Aujourd'hui, j'attends le bus. Un minibus s'arrête devant moi.
Dedans, plein de gosses, dont un qui me regarde fixement en faisant une
affreuse grimace. Outrée, je lui fait mon plus beau doigt d'honneur. Le
minibus s'en va, et là, je vois à l'arrière &quot;École pour enfants
handicapés&quot;. J'ai honte.
VDM</texte><commentable>1</commentable></vdm></vdms></root>
EOF

my $all = <<EOF;
<?xml version="1.0" encoding="UTF-8"?>
<root><active_key>readonly</active_key><vdms><vdm
id="238320"><auteur>Belle</auteur><categorie>inclassable</categorie><date>2008-10-09T14:00:53+02:00</date><je_valide>3696</je_valide><bien_merite>5807</bien_merite><commentaires>82</commentaires><texte>Aujourd'hui,
j'attends le bus. Un minibus s'arrête devant moi. Dedans, plein de
gosses, dont un qui me regarde fixement en faisant une affreuse grimace.
Outrée, je lui fait mon plus beau doigt d'honneur. Le minibus s'en va,
et là, je vois à l'arrière &quot;École pour enfants handicapés&quot;.
J'ai honte. VDM</texte><commentable>1</commentable></vdm><vdm
id="238305"><auteur>cyberg</auteur><categorie>travail</categorie><date>2008-10-09T13:43:02+02:00</date><je_valide>5800</je_valide><bien_merite>350</bien_merite><commentaires>37</commentaires><texte>Aujourd'hui,
mes collègues n'ont rien trouvé de mieux que de me refaire mon badge et
de le remettre dans mon vestiaire en mettant &quot;gynécologue&quot;
dessus. J'ai travaillé la matinée, dans le magasin de bricolage où je
bosse au rayon plomberie/sanitaire.
VDM</texte><commentable>1</commentable></vdm><vdm
id="238213"><auteur>maggiethecat</auteur><categorie>inclassable</categorie><date>2008-10-09T11:35:17+02:00</date><je_valide>8072</je_valide><bien_merite>487</bien_merite><commentaires>29</commentaires><texte>Aujourd'hui,
je me prends les pieds dans le trottoir et je m'étale de tout mon long
en plein centre-ville. Quand je me suis relevée, je me suis retrouvée
face à tout un cortège funéraire essayant tant bien que mal de ne pas
rire. Ok, j'ai égayé leur journée mais moi, j'ai mal !
VDM</texte><commentable>1</commentable></vdm><vdm
id="238202"><auteur>nemito</auteur><categorie>argent</categorie><date>2008-10-09T11:16:44+02:00</date><je_valide>8022</je_valide><bien_merite>1164</bien_merite><commentaires>39</commentaires><texte>Aujourd'hui,
début du mois, je suis déjà à découvert. Ce soir, je découvre dans ma
boîte aux lettres et pour la première fois de ma vie de jeune salariée,
l'existence de la taxe d'habitation.
VDM</texte><commentable>1</commentable></vdm><vdm
id="238199"><auteur>Kiki</auteur><categorie>inclassable</categorie><date>2008-10-09T11:13:34+02:00</date><je_valide>4614</je_valide><bien_merite>6138</bien_merite><commentaires>41</commentaires><texte>Aujourd'hui,
alors que je passais sur un passage pour piéton, c'est un pote qui se
trouve arrêté en voiture pour me laisser passer. Pour déconner, je me
mets à danser n'importe comment et montre mes fesses. Il ouvre la
portière, descend, et m'applaudit. C'était pas lui mais un illustre
inconnu. VDM</texte><commentable>1</commentable></vdm><vdm
id="238137"><auteur>Speee</auteur><categorie>amour</categorie><date>2008-10-09T09:07:53+02:00</date><je_valide>10588</je_valide><bien_merite>542</bien_merite><commentaires>83</commentaires><texte>Aujourd'hui,
mon copain m'a annoncé qu'il aimait être avec moi car on n'était pas
vraiment en couple. Ah bon ?
VDM</texte><commentable>1</commentable></vdm><vdm
id="238102"><auteur>sottise</auteur><categorie>inclassable</categorie><date>2008-10-09T03:22:32+02:00</date><je_valide>9906</je_valide><bien_merite>854</bien_merite><commentaires>60</commentaires><texte>Aujourd'hui,
j'ai mes règles et je suis en retard pour aller travailler. Je prends
une serviette hygiénique, enlève la partie collante et la pose à
l'envers sur le lit. Au moment de l'utiliser, introuvable ! Mes
collègues l'ont retrouvée : elle était collée sur mes fesses. Déjà 2h
que je bosse... VDM</texte><commentable>1</commentable></vdm><vdm
id="238035"><auteur>riri</auteur><categorie>enfants</categorie><date>2008-10-08T23:59:50+02:00</date><je_valide>9307</je_valide><bien_merite>774</bien_merite><commentaires>81</commentaires><texte>Aujourd'hui,
ma mère a raconté à mes potes que, lorsque j'étais petit, j'avais une
peur bleue du tyrolien dans le Juste Prix.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237736"><auteur>loliloling</auteur><categorie>enfants</categorie><date>2008-10-08T20:04:27+02:00</date><je_valide>11650</je_valide><bien_merite>786</bien_merite><commentaires>76</commentaires><texte>Aujourd'hui,
en rentrant de mon travail, mon fils de 7 ans me dit que sa petite sœur
a vomi mais que c'est pas grave parce qu'il a passé l'aspirateur.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237727"><auteur>lilouette25</auteur><categorie>travail</categorie><date>2008-10-08T19:56:45+02:00</date><je_valide>12886</je_valide><bien_merite>1444</bien_merite><commentaires>87</commentaires><texte>Aujourd'hui,
le prof a distribué les exposés en Sciences du langage. On choisissait
une date et on gagnait un sujet : j'ai eu les isotopies discursives à
disjonction paradigmatique et syntagmatique.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237670"><auteur>xplp</auteur><categorie>inclassable</categorie><date>2008-10-08T19:17:46+02:00</date><je_valide>12613</je_valide><bien_merite>1431</bien_merite><commentaires>61</commentaires><texte>Aujourd'hui,
et depuis quelque temps, je sors tellement peu de chez moi et ma vie est
tellement nulle que je me suis fait un ami qui me ressemble. C'est un
pigeon amputé d'une patte. Je me suis pris de pitié pour lui, je le
nourris à ma fenêtre et lui parle.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237669"><auteur>doomiiino</auteur><categorie>inclassable</categorie><date>2008-10-08T19:17:27+02:00</date><je_valide>9689</je_valide><bien_merite>1258</bien_merite><commentaires>19</commentaires><texte>Aujourd'hui,
j'ai appris que mon portable savait faire plein de choses ! Il a réussi
à s'allumer et à taper un mauvais code PIN trois fois de suite. Clap
clap clap, je n’aurais pas fait mieux.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237505"><auteur>Baloo51</auteur><categorie>argent</categorie><date>2008-10-08T17:10:09+02:00</date><je_valide>10155</je_valide><bien_merite>5500</bien_merite><commentaires>54</commentaires><texte>Aujourd'hui,
en fouillant les poches d'un ancien manteau, j'ai retrouvé un chèque de
130 euros qui m'était destiné. C'est génial ! Enfin, ça le serait si on
était toujours en 2005.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237502"><auteur>çamousse</auteur><categorie>enfants</categorie><date>2008-10-08T17:09:06+02:00</date><je_valide>14029</je_valide><bien_merite>677</bien_merite><commentaires>84</commentaires><texte>Aujourd'hui,
c'est mon jour de congé. J'attends un appel de mon patron pour la grande
réunion de demain. C'est ma fille, 6 ans, qui décroche. &quot;Maman peut
pas répondre, elle se touche dans la baignoire.&quot; En effet, j'étais
bien dans la baignoire, à me DOUCHER.
VDM</texte><commentable>1</commentable></vdm><vdm
id="237429"><auteur>tatouaie</auteur><categorie>sante</categorie><date>2008-10-08T16:14:23+02:00</date><je_valide>11178</je_valide><bien_merite>2362</bien_merite><commentaires>65</commentaires><texte>Aujourd'hui,
et comme chaque jour en rentrant chez moi, mon chien m'attend devant la
porte. Cette fois, il décide de me mordiller le mollet. Bon, ce ne
serait pas grave si, 2 h auparavant, je ne m'étais pas fait mon
tatouage... au mollet.
VDM</texte><commentable>1</commentable></vdm></vdms><code>1</code><pubdate>2008-10-09T19:54:38+02:00</pubdate><erreurs></erreurs></root>
EOF

#' ;

my @good_ids = (238320, 238305, 238213, 238202, 238199, 238137, 238102,
           238035, 237736, 237727, 237670, 237669, 237505, 237502, 237429);

my @good_auteurs = qw/Belle cyberg maggiethecat nemito Kiki Speee
                    sottise riri loliloling lilouette25 xplp doomiiino Baloo51
                    çamousse tatouaie/;

BEGIN { my $plan = 0; }
plan tests => $plan;

my $t = XML::Twig->new();

BEGIN { $plan += 2; }
$t->parse($one);
my $root = $t->root;
my $vdms = $root->first_child('vdms');
my $vdm = $vdms->first_child('vdm');
my $vdm_parsed = WWW::VieDeMerde::Message->new($vdm);
ok(defined $vdm_parsed, "WWW::VieDeMerde::Message->new() renvoie quelquechose");
ok($vdm_parsed->isa('WWW::VieDeMerde::Message'), "qui a la bonne classe");

$t->parse($all);
my @vdms = WWW::VieDeMerde::Message->parse($t);

BEGIN { $plan += 1; }
is(@vdms, 15, "bien 15 vdms dans le gros fragment");

BEGIN { $plan += 2; }
my @ids = map {$_->id} @vdms;
is_deeply(\@ids, \@good_ids, "bons identifieurs");
my @auteurs = map {$_->auteur} @vdms;
is_deeply(\@auteurs, \@good_auteurs, "bons auteurs");




