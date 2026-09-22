# Cours Godot — 2D, 3D, puis HD-2D

Parcours pour apprendre à faire un jeu avec **Godot 4**, dans l’ordre qui sert Projet-Aurora : d’abord un petit jeu 2D, ensuite la 3D, ensuite le look **HD-2D** (monde 3D, personnages en pixel art, lumières, bloom, brouillard).

Tu n’as pas besoin d’Unreal, ni de droits administrateur. Godot se lance depuis un dossier utilisateur.

## Comment suivre

1. Lis [00 — Avant de commencer](00-avant-de-commencer.md) et installe Godot 4.
2. Fais **toute** la partie 2D avant la 3D. Chaque leçon se termine par quelque chose qui bouge à l’écran.
3. Ne saute pas les exercices. Le code des leçons est le cours : tu le tapes dans l’éditeur.
4. Les scripts dans [solutions/](solutions/) sont le corrigé. Ouvre-les seulement si tu es bloqué depuis un moment.
5. Le [glossaire](glossaire.md) traduit les mots du moteur.

Travaille dans **un projet Godot par partie** :

| Partie | Nom du projet | But |
| --- | --- | --- |
| [01 — 2D](01-2d/README.md) | `Ruelles` | Te déplacer, ramasser, éviter, afficher un score |
| [02 — 3D](02-3d/README.md) | `Sanctuaire` | Le même genre de scène, en volume |
| [03 — HD-2D](03-hd2d/README.md) | `AuroraSlice` | Le look Octopath : sprites dans un monde 3D éclairé |

## Ce que tu sauras faire à la fin

- Créer des scènes, des nœuds, des scripts GDScript et des signaux.
- Faire un personnage qui marche, des collisions, un ennemi, une interface.
- Éclairer une scène 3D et suivre le personnage avec une caméra en plongée.
- Afficher un sprite pixel qui regarde toujours la caméra, avec bloom et brouillard.
- Ramasser une sparkle sur un totem et lancer un combat au tour par tour.

## Rythme

Une leçon = une session. Si tu bloques plus de 20 minutes, compare avec le corrigé, corrige **une** différence, puis reviens à la leçon suivante sans tout copier d’un coup.

Godot utilisé ici : **4.x** (4.3 à 4.7 conviennent). Langage : **GDScript**.
