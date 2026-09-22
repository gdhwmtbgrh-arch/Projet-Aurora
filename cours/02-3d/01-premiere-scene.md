# 01 — Première scène 3D

## Objectif

Créer un monde 3D avec un sol et comprendre les axes.

## Projet

1. Nouveau projet `Sanctuaire`, rendu **Forward+**.
2. Dossiers `scenes`, `scripts`, `art`.
3. Nouvelle scène, racine `Node3D`, nom `Monde`.
4. Enregistre `scenes/monde.tscn` et définis-la comme scène principale.

## Axes

En 3D Godot :

- **X** va vers la droite.
- **Y** va vers le haut.
- **Z** va vers toi (hors de l’écran) quand tu regardes l’origine de face.

Le sol est un plan **XZ**. La hauteur est **Y**. Dans Ruelles, Y était la verticale de l’écran. Ici Y est la hauteur. C’est le changement le plus important de cette partie.

## Sol

1. Sous `Monde`, ajoute `MeshInstance3D`, nom `Sol`.
2. **Mesh** → `PlaneMesh`. **Size** : `40` et `40`.
3. Le plan est centré sur l’origine, à `Y = 0`.

`F6`. Vue 3D de l’éditeur : clic droit pour regarder, molette pour zoomer, clic molette pour déplacer. Touche `F` cadre la sélection.

Tu vois un grand carré gris. La fenêtre de jeu peut sembler vide si aucune caméra n’existe : c’est normal jusqu’à la leçon 3. Reste dans l’éditeur pour l’instant.

## Exercice

Ajoute un `MeshInstance3D` nommé `Repere`, mesh `BoxMesh`, taille `(0.4, 2, 0.4)`, position `(0, 1, 0)`. C’est un poteau à l’origine. Tu t’en serviras pour viser la caméra.

## Bloqué ?

- Pas de `PlaneMesh` : tu es encore dans un nœud 2D. La racine doit être `Node3D`.
- Le plan est tout petit : la taille est en mètres, pas en pixels. `40` est déjà une grande place.
