# 02 — Personnage et gravité

## Objectif

Déplacer un corps 3D sur le plan XZ, avec une gravité qui le pose au sol.

## Scène

1. Nouvelle scène, racine `CharacterBody3D`, nom `Joueur`, groupe `player`.
2. Enfant `MeshInstance3D`, mesh `CapsuleMesh`, rayon `0.35`, hauteur `1.6`.
3. Décale le mesh de `(0, 0.8, 0)` pour que le bas de la capsule soit aux pieds du corps (l’origine du `CharacterBody3D`).
4. Enfant `CollisionShape3D`, shape `CapsuleShape3D`, même rayon et hauteur, même décalage Y.
5. `scenes/joueur.tscn`.

## Script `scripts/joueur.gd`

```gdscript
extends CharacterBody3D

@export var speed := 4.0
var gravity := 9.8

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(input.x, 0.0, input.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
```

`Input.get_vector` renvoie un `Vector2`. On le pose sur X et Z, pas sur Y. Y reste la gravité.

`speed` vaut `4` mètres par seconde, plus `200` pixels. Les unités ont changé.

## Le poser

Dans `monde.tscn`, le sol n’a **pas encore** de collision. Ajoute tout de suite, sur `Sol` :

1. Sélectionne `Sol`.
2. Ajoute un frère `StaticBody3D` nommé `SolCollision` (ou mets le `MeshInstance3D` en enfant d’un `StaticBody3D`).
3. Le plus simple : crée `StaticBody3D` nommé `SolBody`, mets-y un `CollisionShape3D` avec un `BoxShape3D` de taille `(40, 0.2, 40)`, position `(0, -0.1, 0)`.

Le mesh du sol reste visible. La boîte plate l’empêche de traverser.

Instance `joueur.tscn` à `(0, 2, 0)`. Il tombera sur le sol dès qu’une caméra permettra de lancer. Tu peux déjà lancer : Godot affiche un avertissement « pas de caméra » et montre une vue par défaut. Les flèches doivent changer la position du joueur (regarde l’inspecteur en mode distant, ou attends la leçon suivante).

## Exercice

Passe `speed` à `8` dans l’inspecteur de la scène `joueur.tscn`. Remets `4` ensuite.

## Bloqué ?

- Le joueur tombe sans fin : la collision du sol est absente, trop fine, ou loin sous l’origine.
- Il glisse de travers : tu as mis l’entrée clavier sur Y. Relis `Vector3(input.x, 0.0, input.y)`.
- La capsule est à moitié dans le sol : le mesh ou la forme n’est pas remonté de `0.8` en Y.
