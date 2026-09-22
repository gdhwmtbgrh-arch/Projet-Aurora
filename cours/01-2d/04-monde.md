# 04 — Le monde et les murs

## Objectif

Empêcher le joueur de traverser les maisons. L’image et la collision sont deux choses distinctes.

## Un mur

Dans `main.tscn` :

1. Sous `Main`, ajoute un `StaticBody2D` nommé `Mur`.
2. Enfant `CollisionShape2D`, shape `RectangleShape2D`, taille environ `80×60`.
3. Enfant `Polygon2D` de la même taille, couleur `#3a3344`, pour **voir** le mur.
4. Aligne le polygone et le rectangle de collision. Sélectionne `Mur` et déplace-le sur le sol, pas sur le joueur.

`F5`. Marche vers le mur. Le pion s’arrête.

`StaticBody2D` ne bouge pas. `move_and_slide()` détecte sa collision et annule la partie de la vitesse qui entrerait dedans.

## Plusieurs murs

Duplique `Mur` (`Ctrl+D`) trois fois. Dispose un couloir : deux murs en haut, deux sur les côtés, un passage au milieu. Laisse de la place pour marcher.

Tu peux aussi garder le `Polygon2D` « Maison » de la leçon 01 comme décor **sans** collision, pour voir la différence : on traverse le décor, pas le `StaticBody2D`.

## Origine des formes

Le rectangle de collision est centré sur le `CollisionShape2D`. Le polygone, lui, part souvent de son coin haut-gauche. S’ils ne se recouvrent pas, déplace le `Polygon2D` ou le `CollisionShape2D` jusqu’à ce que le dessin et le blocage coïncident. Teste en marchant, pas seulement à l’œil.

## Exercice

Ferme le couloir avec un cinquième mur, vérifie que tu es coincé, puis rouvre un passage d’au moins 80 pixels. Le joueur doit pouvoir faire le tour.

## Bloqué ?

- Tu traverses : il manque le `CollisionShape2D`, ou sa forme est trop petite, ou le mur est sur un autre calque de collision. Laisse les calques par défaut (`1` et `1`) pour l’instant.
- Tu restes collé au mur dès le départ : le joueur est né **dans** le mur. Éloigne-le.
