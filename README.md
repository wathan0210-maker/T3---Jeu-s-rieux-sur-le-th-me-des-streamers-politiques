# Mordus Inc.

> Jeu sérieux sur les streamers politiques et l'élection présidentielle française de 2027.
> Projet T3 du groupe **VIN26-T3-J** (TP4), IUT Robert Schuman, Université de Strasbourg.
> Nom du projet provisoire.

**Légende utilisée dans ce README :** **[Décidé]** = décision de l'équipe, **[Piste]** = idée proposée mais pas validée, **[À confirmer]** = point encore ouvert.

---

## Sommaire

1. [Présentation](#1-présentation)
2. [Équipe et encadrement](#2-équipe-et-encadrement)
3. [Concept du jeu](#3-concept-du-jeu)
4. [Mécanique de débat](#4-mécanique-de-débat)
5. [Adversaires](#5-adversaires)
6. [Le débat contre Léa Fontaine](#6-le-débat-contre-léa-fontaine)
7. [Retour visuel des attaques](#7-retour-visuel-des-attaques)
8. [Cahier des charges gameplay](#8-cahier-des-charges-gameplay)
9. [Technique : Godot et Dialogue Manager](#9-technique--godot-et-dialogue-manager)
10. [Planning : PERT et Gantt](#10-planning--pert-et-gantt)
11. [Livrables scolaires](#11-livrables-scolaires)
12. [Fichiers du projet](#12-fichiers-du-projet)
13. [Questions ouvertes](#13-questions-ouvertes)

---

## 1. Présentation

Mordus Inc. est un **visual novel d'enquête et de débat**, inspiré d'*Ace Attorney* et de *Danganronpa*. Le joueur incarne un(e) streamer politique débutant(e) qui ne veut laisser passer que la vérité pendant ses lives.

**Pourquoi ce jeu.** Les jeunes s'informent de plus en plus par les streams et les réseaux plutôt que par les médias traditionnels, dans des formats peu encadrés où la désinformation circule facilement. Le jeu veut sensibiliser simplement à la vérification de l'information avant l'élection présidentielle de 2027.

**Ce que le joueur apprend :**

- rechercher l'information et vérifier ses sources ;
- repérer les fake news ;
- **repérer les mensonges et les incohérences des discours politiques**, et distinguer l'erreur sincère de la tromperie volontaire ;
- confronter une personnalité politique à des faits vérifiés, en direct.

**Public cible :** les jeunes qui s'informent surtout par les streams et les réseaux.

**Objectif du rendu [Décidé] :** un **prototype jouable** avec les deux phases et **un seul débat complet, contre Léa Fontaine** (l'écologiste). Les débats 2 à 5 ne seront ajoutés que s'il reste du temps. L'équipe préfère une version qui marche avec un débat plutôt que plusieurs débats inachevés.

**Date de rendu du T3 :** 18/12/2026.

---

## 2. Équipe et encadrement

| Membre | Rôles [Décidé] |
|---|---|
| Nathan WEISS | Chef de projet, game designer, graphiste, écrivain |
| Emile FLATTER | Développeur |
| Kadir EKICI | Développeur |

- **Enseignants référents du sujet T3 :** Jean-Pierre Fonné, Laurence Kaeuffer.
- **Cours G31 (gestion de projet) :** Isabelle Roy, Laurence Kaeuffer, Jean-Pierre Fonné.

---

## 3. Concept du jeu

**[Décidé]** Le jeu alterne deux phases.

### Phase 1 : l'enquête

Le joueur se renseigne sur un **bureau d'ordinateur simulé** : moteur de recherche, articles, redirections vers d'autres articles ou vers des fake news. Il range les « preuves » qu'il trouve dans un **dossier d'indices**. Une application d'aide est disponible sur le bureau.

### Phase 2 : le débat

Le joueur affronte un adversaire **en stream (format duplex)**. Il doit démentir les erreurs de l'adversaire avec les preuves récupérées, sous le regard d'un **chat Twitch simulé**. Deux jauges suivent la partie : **crédibilité** et **nombre de viewers**.

**Postulat narratif.** Quel que soit son bord politique, un adversaire peut dire des choses fausses ou inventées, pour gagner en crédibilité ou par simple méconnaissance. Le protagoniste met ces erreurs en lumière pour obtenir un débat de qualité, sans fake news.

**Le métier représenté.** Le jeu se rapproche du **format débat/duplex avec une forte dose de vulgarisation**. Exemples cités par l'équipe (non revérifiés) : Jean Massiet et son format « Backseat », « Le Débat du siècle », « Le Grand Débathon », Hasan Piker côté américain.

---

## 4. Mécanique de débat

**[Décidé]** Inspirée du **« mind chess »** d'*Ace Attorney Investigations 2: Prosecutor's Gambit*.

Après chaque prise de parole de l'adversaire, le joueur choisit une action. **À chaque tour, une seule action est la bonne.** Une mauvaise action coûte des viewers et de la crédibilité, y compris parler quand il fallait se taire.

| Action | Quand c'est la bonne |
|---|---|
| **Poser une question** (contre-attaque) | L'affirmation est vague ou sans source : on pousse l'adversaire à préciser avant de le contredire. |
| **Présenter une preuve** | L'affirmation est précise, fausse et vérifiable, et le joueur a la bonne preuve. |
| **Ne rien faire** (silence) | L'affirmation est vraie, ou c'est une pique sans contenu factuel. Intervenir serait de la mauvaise foi ou détournerait du sujet. |

**Dans l'implémentation (Godot)**, chaque tour propose **4 boutons** : deux contre-attaques (deux questions différentes, une seule est la bonne quand la réponse attendue est « Question »), « Présenter une preuve » et « Ne rien faire ». Voir [section 9](#9-technique--godot-et-dialogue-manager).

---

## 5. Adversaires

**[Décidé]**

| Débat | Adversaire | Statut |
|---|---|---|
| 1 | Jeune femme écolo : **Léa Fontaine** | Script écrit, dans le périmètre du prototype |
| 2 | Homme noir « mascu » | Optionnel, pas écrit |
| 3 | Youtubeur d'extrême droite | Optionnel, pas écrit |
| 4 | Maire communiste | Optionnel, pas écrit |
| 5 | Candidat(e) aux élections, centre | Optionnel, pas écrit |

**Point de vigilance :** rester neutre et crédible face à des adversaires de bords très différents.

---

## 6. Le débat contre Léa Fontaine

**Léa Fontaine** est une streameuse politique récemment lancée, très attachée à l'écologie. **Elle ne ment pas** : elle ignore certaines choses, essaie de ne pas paraître ignorante, mais reste sincère et se corrige quand on lui montre une preuve. Elle sert de contraste avec les futurs adversaires, plus cyniques ou de mauvaise foi.

**Script :** [`dialogues/debat_lea_fontaine.dialogue`](dialogues/debat_lea_fontaine.dialogue) (641 lignes).
Sujet : « La transition écologique, promesses tenables ? ». Introduction, 4 phases, 17 énigmes, conclusion.

| Phase | Thème | Énigmes | Bonnes réponses |
|---|---|---|---|
| 1 | Les emplois verts | 5 | Question, Preuve, Silence, Question, Preuve |
| 2 | Les éoliennes | 4 | Preuve, Silence, Question, Preuve |
| 3 | La participation de tous | 4 | Silence, Question, Preuve, Silence |
| 4 | Les transports | 4 | Silence, Question, Preuve, Question |

Au total : 6 questions, 6 preuves, 5 silences.

**Preuves utilisées dans le script :** Rapport ADEME, Programme de Léa, Bilan électrique RTE, Arrêté de juin 2020, Étude Carbone 4, Empreinte carbone moyenne. Elles doivent pouvoir être trouvées pendant la phase d'enquête.

**Phase 1 détaillée (exemple d'origine du dossier de cadrage) :**

| Tour | Ce que dit Léa | Bonne action | Pourquoi |
|---|---|---|---|
| 1 | La rénovation thermique va créer « des centaines de milliers d'emplois, c'est prouvé » | Question | Vague, sans source. Elle cite alors l'ADEME (200 000 emplois sur 10 ans) |
| 2 | Le chiffre est acquis | Preuve | Le chiffre de l'ADEME dépend d'un budget massif jamais voté |
| 3 | Les renouvelables recrutent déjà | Silence | C'est vrai, contester serait de la mauvaise foi |
| 4 | « Aucun argument valable » contre une transition rapide, seulement des lobbys | Question | Généralisation abusive, la question sur les reconversions la fait se corriger |
| 5 | 5 milliards pour la reconversion | Preuve | Son programme dit 2 milliards, erreur sincère |

---

## 7. Retour visuel des attaques

**Besoin [Décidé] :** reprendre l'esprit visuel du mind chess (plateau néon, formes 3D sombres suspendues devant l'adversaire, détruites par les attaques) **sans pièces d'échecs**. Les formes doivent être distinctes et liées au gameplay, pour que le joueur voie qu'une attaque a porté même si le sprite de l'adversaire reste impassible.

**Piste [Piste, non validée] :** chaque phrase de l'adversaire fait apparaître une forme selon son contenu.

| Ce que dit l'adversaire | Forme |
|---|---|
| Un chiffre | Cube avec le chiffre dessus |
| Une source | Document tamponné |
| Une citation | Bulle de dialogue |
| Une généralisation (« tous », « aucun ») | Grappe de billes identiques |
| Rhétorique creuse, attaque perso | Ballon ou fumée qui se dissipe seul |
| Une affirmation vraie | Bloc de pierre indestructible |

| Action du joueur | Effet |
|---|---|
| Question | La forme se fissure ou devient translucide |
| Bonne preuve | Elle brise la forme, la jauge de l'adversaire chute |
| Mauvaise preuve | Elle rebondit en étincelles, le joueur perd de la crédibilité |
| Bon silence | Les formes creuses se dissipent seules |
| Silence raté | De nouvelles formes s'ajoutent |

---

## 8. Cahier des charges gameplay

**[Décidé]** Tous les points sont obligatoires pour le rendu final. Ils sont classés par priorité : plus un point est bas, plus il est facultatif. Les cases ne sont pas cochées : l'avancement réel n'est pas connu ici, c'est à l'équipe de les mettre à jour.

1. **Boîte de dialogue**
   - [ ] Affichage dynamique du texte
   - [ ] Son pendant l'affichage du texte
   - [ ] Couleur différente selon le personnage qui parle
   - [ ] Police différente selon le personnage qui parle
2. **Sprites des personnages**
   - [ ] Personnage principal
   - [ ] Léa Fontaine (prototype)
   - [ ] Adversaires 2 à 5 (optionnel)
3. **Animation des sprites**
   - [ ] Animations du protagoniste et de Léa
4. **Scénario et « énigmes »**
   - [ ] Débat contre Léa (script écrit, à intégrer et tester)
   - [ ] Débats 2 à 5 (optionnel)
5. **Phase 1 : enquête**
   - [ ] Simulation d'un bureau d'ordinateur
   - [ ] Simulation d'un moteur de recherche
   - [ ] Implémentation des articles
   - [ ] Système de redirection (vers un autre article ou une fake news)
   - [ ] Dossier regroupant les indices récupérés
   - [ ] Application d'aide sur le bureau
6. **Phase 2 : débat**
   - [ ] Simulation d'un face à face
   - [ ] Choix multiples pour interagir
   - [ ] Simulation d'un chat Twitch
   - [ ] Lecture des dialogues intéressante et captivante

---

## 9. Technique : Godot et Dialogue Manager

**Moteur :** Godot, avec l'addon **Dialogue Manager** (choix indiqué par Ayoub le 09/10/2026).

### Conventions des fichiers `.dialogue`

- Un titre `~ pX_eY` pour la réplique de l'adversaire, puis un titre `~ pX_eY_choix` pour les 4 choix.
- Bonne réponse : on passe à l'énigme suivante. Mauvaise réponse : l'adversaire reprend son idée et on revient au choix.
- Chaque choix porte une étiquette de type :
  - `[#color=contre_attaque]` pour les deux contre-attaques ;
  - `[#color=montrer_preuve]` pour la preuve ;
  - `[#color=rien_faire]` pour le silence.
- Un bouton de contre-attaque affiche **seulement la réplique du joueur**. Le libellé « Contre-attaque » et la mention « BONNE RÉPONSE » sont dans un **commentaire** au-dessus du choix.
- Le bouton de preuve affiche seulement **« Présenter une preuve »**, sans le nom de la preuve. Le nom de la preuve attendue est dans le commentaire.
- **Pas de lignes `Chat:`** (chat Twitch) et **pas de `set Debat.credibilite` / `set Debat.viewers`** dans les fichiers de dialogue : le chat et les jauges sont gérés ailleurs.
- `Joueur` est un nom provisoire pour le personnage principal.

Exemple tiré du script de Léa :

```
~ p1_e1_choix
Joueur: Prouvé... vraiment ?
# Contre-attaque (BONNE RÉPONSE)
- Prouvé par qui ? [#color=contre_attaque]
    Joueur: « Prouvé », d'accord. Mais par qui ? Tu as une source ?
    Léa: Euh... oui ! C'est l'ADEME. Ils parlent de... 200 000 emplois sur dix ans, je crois.
    => p1_e2
# Présenter une preuve : Rapport ADEME
- Présenter une preuve [#color=montrer_preuve]
    ...
    => p1_e1_choix
```

**[À confirmer]** Comment le jeu sait quelle preuve est la bonne, et où sont gérés les jauges et le chat Twitch : ce n'est pas décrit dans les sources du projet.

---

## 10. Planning : PERT et Gantt

Dossier complet (doc partagé) : **[Mordus Inc. – Graphe PERT et diagramme de Gantt (T3)](https://claude.ai/code/artifact/b840bd6a-7215-42f6-941b-4be3cf67d815)**.
Version refaite le 09/10/2026 à partir du Gantt Beesbusy de l'équipe. Durées en jours ouvrés, jour 0 = lundi 7 septembre 2026.

### Tâches

| Tâche | Intitulé | Dates | Durée (j) | Antériorités | Responsable |
|---|---|---|---|---|---|
| A | Cadrage : concept, cahier des charges, dossier de cadrage | 07/09 – 18/09 | 10 | aucune | Groupe |
| B | Choix du moteur et des outils | 21/09 – 25/09 | 5 | A | Groupe |
| C | Scénario et énigmes du débat de Léa | 21/09 – 01/10 | 9 | A | Nathan |
| D | Sprites des personnages principaux | 21/09 – 12/10 | 16 | A | Nathan |
| E | Boîte de dialogue | 21/09 – 02/10 | 10 | A | Kadir |
| F | Phase 1 : bureau et moteur de recherche simulés | 21/09 – 09/10 | 15 | A | Emile |
| G | Phase 1 : articles, redirections, dossier d'indices | 12/10 – 30/10 | 15 | C, F | Emile |
| H | Phase 2 : simulation du débat | 05/10 – 30/10 | 20 | E | Kadir |
| I | Animation des sprites | 13/10 – 30/10 | 14 | D | Nathan |
| J | Intégration du prototype | 02/11 – 13/11 | 10 | B, G, H, I | Groupe |
| K | Tests joueurs et ajustements | 16/11 – 27/11 | 10 | J | Groupe |
| M | Finalisation et rendu du prototype | 30/11 – 04/12 | 5 | K | Groupe |
| N | Débats 2 à 5 (optionnelle) | 07/12 – 17/12 | 9 | M | Groupe |

### Chemin critique

Trois chemins critiques de **65 jours ouvrés** mènent au prototype du **4/12/2026** :

- A → E → H → J → K → M
- A → F → G → J → K → M
- A → D → I → J → K → M

Seules **B** (25 jours de marge) et **C** (6 jours) ont de la marge. Les trois branches (débat, enquête, sprites) finissent toutes le 30/10 pour une intégration le 2/11 : un jour de retard sur l'une d'elles décale tout le reste. Si le prototype prend du retard, N est la première tâche à abandonner. Les vacances scolaires ne sont pas déduites.

### Jalons

| Jalon | Date | Sens |
|---|---|---|
| J1 : dossier de cadrage remis | 20/09/2026 | Concept et cahier des charges figés |
| J2 : phases d'enquête et de débat développées | 30/10/2026 | Fin des trois branches critiques |
| J3 : prototype jouable du débat de Léa | 13/11/2026 | Point de décision pour les débats optionnels |
| J4 : rendu du T3 | 18/12/2026 | Date de rendu |

**[À confirmer]**
- G démarre le 12/10 dans le PERT (après F), alors que Beesbusy indique le 09/10.
- B (choix du moteur) est relié à l'intégration J, faute de successeur direct.
- Le fichier [`mordus-gantt/beesbusy_import_T3_rempli.xlsx`](mordus-gantt/beesbusy_import_T3_rempli.xlsx) date de la **première version** du planning : ses dates et responsables (par exemple E à Emile, F à Kadir, N du 05/10 au 27/11) ne correspondent plus au PERT refait le 09/10. C'est le doc PERT/Gantt qui fait foi.

---

## 11. Livrables scolaires

| Livrable | Échéance | État |
|---|---|---|
| Dossier de cadrage T3 | 20/09/2026 (par mail) | Rendu. Écarts relevés : sous-partie « attendus » absente, tableau du temps passé remplacé par un tableau de rôles, carte influence/intérêt sous forme de colonne et non de matrice |
| Dossier G31 « Graphe PERT et diagramme de Gantt » | Sur papier, au plus tard le jour de l'oral (dernière séance de TP G31) | Rédigé dans le doc PERT/Gantt. Reste à compléter : retour réflexif sur les séances, tableau des temps consommés |
| Prototype du jeu (rendu T3) | 18/12/2026 | En cours, prototype prévu le 04/12/2026 |

### Parties prenantes (dossier de cadrage)

| Partie prenante | Rôle | Influence |
|---|---|---|
| Équipe projet (Mordus Inc.) | Conception, développement, écriture, design | Forte |
| Encadrants du T3 | Suivi pédagogique, évaluation | Moyenne |
| Joueurs / public cible | Jouer, tester, faire des retours | Moyenne |
| Établissement (IUT) | Cadre, ressources, calendrier | Faible |

### Points de vigilance

- Équilibre entre les deux phases : stimulant et pédagogique.
- Neutralité politique face à des adversaires de bords très différents.
- Système de dialogue ramifié propre.
- Répartition du temps entre écriture, graphisme et développement.
- Tests auprès de profils variés, puis ajustements.

---

## 12. Fichiers du projet

| Fichier | Contenu |
|---|---|
| [`README.md`](README.md) | Ce document |
| [`contexte-projet-mordus-inc.md`](contexte-projet-mordus-inc.md) | Contexte de référence du projet (concept, mécanique, adversaires, cahier des charges, dossier de cadrage) |
| [`dialogues/debat_lea_fontaine.dialogue`](dialogues/debat_lea_fontaine.dialogue) | Script complet du débat contre Léa, au format Dialogue Manager |
| [`mordus-gantt/beesbusy_import_T3_rempli.xlsx`](mordus-gantt/beesbusy_import_T3_rempli.xlsx) | Fichier d'import Beesbusy (première version du planning, voir [section 10](#10-planning--pert-et-gantt)) |
| [Doc PERT/Gantt](https://claude.ai/code/artifact/b840bd6a-7215-42f6-941b-4be3cf67d815) | Dossier G31 : PERT, Gantt, jalons, conclusion |

---

## 13. Questions ouvertes

- [ ] **Nom du personnage principal** (« Joueur » pour l'instant).
- [ ] Détail de la phase 2 (débat) et de l'**animation des sprites**.
- [ ] **Formes finales** du plateau de débat (piste de la section 7 à valider).
- [ ] Gestion des **jauges** et du **chat Twitch** dans Godot (hors des fichiers de dialogue).
- [ ] Articles et fake news de la phase d'enquête pour le débat de Léa (liés aux 6 preuves du script).
- [ ] Scénarios et énigmes des **débats 2 à 5** (optionnels).
- [ ] **Temps passé par membre** : tableau à remplir pour le dossier G31.
- [ ] Retour réflexif sur les deux séances de TP G31.
- [ ] Date exacte de la dernière séance de TP G31 (date de l'oral et de remise du dossier papier).
- [ ] Hypothèses du PERT : départ de G le 12/10, lien B → J.
- [ ] Mettre à jour l'import Beesbusy pour qu'il corresponde au PERT du 09/10.
