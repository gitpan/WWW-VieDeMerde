package WWW::VieDeMerde;

use warnings;
use strict;

use Carp;

use LWP::UserAgent;
use XML::Twig;

use WWW::VieDeMerde::Message;

=encoding utf8

=head1 NAME

WWW::VieDeMerde - A perl module to use the viedemerde.fr API

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use WWW::VieDeMerde;
    
    my $toto = WWW::VieDeMerde->new();
    my $tata = $toto->last();
    my $tata = $toto->page(17);
    my $tata = $toto->random();
    
    print $tata->texte, $tata->auteur;

=head1 DESCRIPTION

viedemerde.fr is a french microblog where people post short
messages in order to show how their life is crappy. It presents a
simple but efficient http-based API. Since the website is only in
French, this module will probably be useful only for French speaker Perl
programmers and most of this documentation will be written in
French.

Ce module essaye de fournir une interface complète pour l'API 1.2, telle
que documentée ici L<http://www.viedemerde.fr/api/documentation>.

=head1 METHODS

=head2 new

Cette fonction crée un nouvel objet WWW::VieDeMerde utilisable pour
dialoguer avec le serveur.

Les paramètres sont :

=over 4

=item * key

Votre clé développeur. La valeur par défaut ("readonly") est suffisante
pour toutes les fonctions qui ne tentent pas d'écrire dans la base de
données. Vous pouvez demander une clé à l'adresse suivante
L<http://www.viedemerde.fr/api/developpeurs>.

=item * token

La clé d'identification pour se connecter à un compte utilisateur. Voir
l'explication ici L<http://www.viedemerde.fr/api/documentation#ident>.

=item * url

L'URL utilisée pour parler au serveur. La seule valeur intéressante est
L<http://sandbox.viedemerde.fr/1.2/> au lieu de
L<http://api.viedemerde.fr/1.2/>.

=back

=cut

sub new {
    my $class  = shift;
    my %params = @_;

    my %defaults = (
                    key => "readonly",
                    token => undef,
                    url => "http://api.viedemerde.fr/1.2/",
                    autoerrors => 0,
                    );

    my $self = {};
    bless($self, $class);

    for (keys %defaults) {
        if (exists $params{$_}) {
            $self->{$_} = $params{$_};
        }
        else {
            $self->{$_} = $defaults{$_};
        }
    }

    $self->{ua} = LWP::UserAgent->new();
    $self->{twig} = XML::Twig->new();

    return $self;
}

=head2 page

C<< $vdm->page() >> renvoie la liste des 15 dernières entrées.

C<< $vdm->page($n) >> la page $n (0 étant la plus récente).

Renvoie la liste vide si la page demandée est vide.

=cut

sub page {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "last", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 last

C<< $vdm->last >> est un alias pour C<< $vdm->page >>

=cut

sub last {
    my $self = shift;
    my $page = shift;

    return $self->page();
}

=head2 random

C<< $vdm->page() >> renvoie une entrée aléatoire.

=cut

sub random {
    my $self = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "random");
    if (parse($xml, $t)) {
        my @l = WWW::VieDeMerde::Message->parse($t);
        return $l[0];
    }
    return undef;
}

=head2 top

C<< $vdm->top() >> renvoie le top global.

Accepte un numéro de page en argument.

=cut

sub top {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "top", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 top_jour

C<< $vdm->top_jour() >> renvoie le top du jour.

Accepte un numéro de page en argument.

=cut

sub top_jour {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "top_jour", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 top_semaine

C<< $vdm->top_semaine() >> renvoie le top de la semaine.

Accepte un numéro de page en argument.

=cut

sub top_semaine {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "top_semaine", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 top_mois

C<< $vdm->top_mois() >> renvoie le top du mois.

Accepte un numéro de page en argument.

=cut

sub top_mois {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "top_mois", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 flop

C<< $vdm->flop() >> renvoie le flop global.

Accepte un numéro de page en argument.

=cut

sub flop {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "flop", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 flop_jour

C<< $vdm->flop_jour() >> renvoie le flop du jour.

Accepte un numéro de page en argument.

=cut

sub flop_jour {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "flop_jour", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 flop_semaine

C<< $vdm->flop_semaine() >> renvoie le flop de la semaine.

Accepte un numéro de page en argument.

=cut

sub flop_semaine {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "flop_semaine", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 flop_mois

C<< $vdm->flop_mois() >> renvoie le flop du mois.

Accepte un numéro de page en argument.

=cut

sub flop_mois {
    my $self = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", "flop_mois", $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head2 cat

C<< $vdm->cat($cat) >> renvoie les dernières entrées de la catégorie C<$cat>.

Accepte un numéro de page en argument.

=cut

sub cat {
    my $self = shift;
    my $cat = shift;
    my $page = shift;

    my $t = $self->{twig};

    my $xml = $self->run("view", $cat, $page);
    if (parse($xml, $t)) {
        my @result = WWW::VieDeMerde::Message->parse($t);
        return @result;
    }
    return undef;
}

=head1 INTERNAL METHODS AND FUNCTIONS

Rien de de tout ceci n'est destiné aux utilisateurs !

=head2 run

=cut

sub run {
    my $self = shift;
    my @commands = grep {defined $_} @_;

    my $token = $self->{token};
    my $key = $self->{key};
    my $url = $self->{url};

    my $ua = $self->{ua};

    my $cmd = $url . "/" . join("/", @commands);
    if (defined $key) {
        $cmd .= "?key=$key";
    }
    if (defined $token) {
        $cmd .= "&token=$token";
    }

    my $response = $ua->get($cmd);

    if ($response->is_success) {
        return $response->content;
    }
    else {
        carp $response->status_line;
        return undef;
    }
}

=head2 parse

=cut

sub parse {
    my $xml = shift;
    my $t = shift;

    if (defined($xml)) {
        if ($t->safe_parse($xml)) {
            my $root = $t->root;
            if ($root->tag eq "root") {
                if ($root->first_child("code")->text == 1) {
                    return 1;
                }
            }
        }
    }

    return 0;
}

=head2 errors

=cut

sub errors {
    my $t = shift;

    return undef;
}

=head1 AUTHOR

Olivier Schwander, C<< <olivier.schwander at ens-lyon.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-vdm at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-VieDeMerde>. I will
be notified, and then you'll automatically be notified of progress on
your bug as I make changes.




=head1 SUPPORT

A darcs repository is available here :

L<http://chadok.info/darcs/WWW-VieDeMerde>

You can find documentation for this module with the perldoc command.

    perldoc WWW::VieDeMerde


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-VieDeMerde>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-VieDeMerde>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-VieDeMerde>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-VieDeMerde>

=back


=head1 COPYRIGHT & LICENSE

Copyright 2008 Olivier Schwander, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of WWW::VieDeMerde
