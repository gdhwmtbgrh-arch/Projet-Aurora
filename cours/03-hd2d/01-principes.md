# 01 — Ce qu’est le HD-2D

## Objectif

Savoir ce que tu construis, et ce que tu ne construis pas.

## La recette

| Couche | Dans Godot | Rôle |
| --- | --- | --- |
| Décors | `MeshInstance3D` low-poly, textures pixel | Maisons, sol, rochers |
| Personnages | `Sprite3D` en billboard | Elora, le garde, plus tard l’équipe |
| Lumière | `DirectionalLight3D` + `OmniLight3D` | Volume, ombres, sorts |
| Ambiance | `WorldEnvironment` | Ciel, bloom, brouillard |
| Caméra | `Camera3D` oblique + flou de profondeur | Lire la scène comme un diorama |
| Interface | `Control` (labels, boutons) | Dialogue, combat |

Le sprite n’est pas « collé en 2D par-dessus une photo ». Il est **dans** la scène 3D : il a une position, il peut projeter une ombre, la lumière le teinte, le brouillard le prend avec le décor.

## Ce qui ne fait pas le style

- Un jeu 2D avec un flou ajouté sur toute l’image.
- Un jeu 3D réaliste avec des personnages en haute définition.
- Unreal obligatoire. Godot suffit pour cette recette. Le rendu Forward+ de ton PC CAO est le bon réglage.

## Ce que tu réutilises

La partie 2 a déjà le sol, les murs, la caméra qui suit, les lumières, le ramassage. Ici tu changes **l’apparence du personnage** et tu ajoutes la **post-production** plus un **combat**.

## Exercice

Ouvre une image d’Octopath Traveler (ou la vidéo Kanto HD-2D) et note trois choses, par écrit dans un fichier `art/notes.txt` :

1. Où est la caméra (hauteur, angle) ?
2. Qu’est-ce qui est modélisé (sol, murs) et qu’est-ce qui est dessiné (personnages) ?
3. Où voit-on de la lumière qui déborde (bloom) ?

Garde ces trois notes sous les yeux pour les leçons suivantes.

## Bloqué ?

Si tu n’as pas la vidéo : retiens seulement la phrase « décor en volume, gens en pixels, lumière de cinéma ».
