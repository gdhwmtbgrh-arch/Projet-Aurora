# 01 — L’éditeur : nœuds et scènes

## Objectif

Comprendre qu’un jeu Godot est un arbre de nœuds, et afficher un premier carré.

## Créer la scène principale

1. Scène → **Nouvelle scène** → **Autre nœud** → cherche `Node2D` → **Créer**.
2. Renomme-le `Main` (double-clic dans l’arbre).
3. Enregistre : `scenes/main.tscn`.
4. Projet → **Paramètres du projet** → **Général** → **Application** → **Exécution** → **Scène principale** → choisis `main.tscn`.

## Ajouter un sol visible

1. Sélectionne `Main`, `Ctrl+A`, ajoute un `Polygon2D`, nomme-le `Sol`.
2. Dans l’inspecteur, propriété **Polygon**, ajoute quatre points : `(0, 0)`, `(640, 0)`, `(640, 360)`, `(0, 360)`.
3. **Color** : un vert sombre, par exemple `#2f5d38`.

`F6`. Tu dois voir un rectangle vert. La fenêtre fait 1152×648 par défaut : le rectangle n’occupe qu’un coin. C’est voulu. La caméra viendra plus tard.

## Déplacer la vue

Molette = zoom. Clic molette (ou clic milieu) + glisser = déplacer la vue. Ça ne déplace pas le jeu, seulement ton regard dans l’éditeur.

## Ce qu’il faut retenir

- Un nœud enfant se déplace **avec** son parent.
- `Polygon2D` dessine. Il ne bloque personne. Les murs auront une collision séparée.
- Sauvegarde souvent. Godot n’enregistre pas la scène tout seul.

## Exercice

Ajoute un second `Polygon2D` nommé `Maison`, plus petit (80×60), couleur `#3a3344`, quelque part sur le sol. `F6` : les deux formes sont visibles.

## Bloqué ?

Si le polygone ne s’affiche pas, les points sont dans le désordre ou tous au même endroit. Remets les quatre coins dans l’ordre ci-dessus.
