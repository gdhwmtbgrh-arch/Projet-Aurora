# 04 — Sol, murs, décor

## Objectif

Bloquer le joueur avec des volumes, et séparer le décor du gameplay.

## Matériau du sol

Sélectionne le mesh du sol. **Material Override** → **Nouveau StandardMaterial3D**. **Albedo Color** : `#3c6b43`.

Un matériau albedo est la couleur de base, avant les lumières. On affinera l’éclairage à la leçon 6.

## Murs

`StaticBody3D` nommé `Mur` :

- Enfant `MeshInstance3D`, `BoxMesh` `(2, 2, 2)`, position Y = `1` (le cube repose sur le sol).
- Enfant `CollisionShape3D`, `BoxShape3D` de la même taille, même position.
- Matériau albedo `#3a3344`.

Duplique-le pour former une cour ouverte, pas une prison. Laisse une entrée.

`F5`. La capsule s’arrête sur les cubes. Elle ne traverse plus.

## Décor sans collision

Duplique seulement un `MeshInstance3D` (pas le `StaticBody3D`), aplatis-le en dalle ou allonge-le en colonne, et place-le au bord. Tu peux marcher au travers : il n’a pas de `CollisionShape3D`. Sers-t’en pour des arbres lointains, pas pour les murs du chemin.

## Exercice

Fais un couloir de 4 blocs. Vérifie qu’on ne peut pas sortir sur les côtés, et qu’on peut encore atteindre le centre de la cour.

## Bloqué ?

- Tu passes à travers le mesh : la forme de collision manque ou n’est pas au même endroit que le mesh.
- Le cube flotte : sa position Y est trop haute. Le centre d’un cube de hauteur 2 doit être à Y = 1 s’il part du sol.
- Le joueur est éjecté très fort : il est né dans un mur. Replace-le au centre, Y = 2.
