# 03 — Le joueur se déplace

## Objectif

Une scène `Joueur` qui marche avec les flèches, et qui apparaît dans `Main`.

## Scène du joueur

1. Nouvelle scène, racine `CharacterBody2D`, nom `Joueur`.
2. Enfant `Sprite2D`. Dans **Texture**, glisse `icon.svg` (il est à la racine du projet).
3. `Sprite2D` → **Scale** : `0.25` sur X et Y. L’icône Godot sert de pion en attendant un dessin.
4. Enfant `CollisionShape2D`. Dans **Shape**, choisis `RectangleShape2D`. Règle le rectangle pour couvrir le pion (environ 30×30).
5. Enfant `Camera2D`. Dans l’inspecteur : **Enabled** coché, **Zoom** = `2` et `2`.
6. Sélectionne `Joueur` (la racine). Onglet **Nœud** à droite de l’inspecteur → **Groupes** → ajoute `player`.
7. Enregistre `scenes/joueur.tscn`.

Le `CharacterBody2D` ne dessine rien et ne bloque rien sans ses enfants. Le sprite montre. La collision touche. La caméra suit.

## Script

Attache `scripts/joueur.gd` sur la racine `Joueur` :

```gdscript
extends CharacterBody2D

@export var speed := 200.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
```

- `@export` affiche `speed` dans l’inspecteur. Tu peux changer la vitesse sans retoucher le script.
- `ui_left`, `ui_right`, `ui_up`, `ui_down` existent déjà (flèches du clavier).
- `velocity` est la vitesse en pixels par seconde. `move_and_slide()` applique cette vitesse et glisse le long des murs.

## Poser le joueur dans la ruelle

1. Rouvre `scenes/main.tscn`.
2. Glisse `joueur.tscn` depuis le Système de fichiers sur le nœud `Main`.
3. Place l’instance vers le centre du sol vert, par exemple position `(320, 180)`.
4. `F5`.

Les flèches déplacent le pion. La vue suit grâce à `Camera2D`.

## Exercice

Dans l’inspecteur de l’instance (pas le fichier `joueur.tscn` si tu veux tester vite : sélectionne l’instance dans `Main`), passe `speed` à `80`, relance, puis remets `200`.

## Bloqué ?

- Le pion ne bouge pas : le script est sur `Sprite2D` au lieu de `Joueur`, ou tu n’es pas en `_physics_process`.
- La caméra ne suit pas : le nœud `Camera2D` doit être **enfant du joueur**, pas de `Main`.
- Tout est noir : le sol est hors champ. Place le joueur sur le rectangle vert.
