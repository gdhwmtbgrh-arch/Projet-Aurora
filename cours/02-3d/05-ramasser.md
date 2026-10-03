# 05 — Ramasser en 3D

## Objectif

Refaire le signal `collected` avec un `Area3D`.

## Scène `scenes/orbe.tscn`

Racine `Area3D`, nom `Orbe`.

- `MeshInstance3D`, `SphereMesh`, rayon `0.35`.
- `CollisionShape3D`, `SphereShape3D`, rayon `0.6` (un peu plus grand que l’image, pour que le contact soit lisible).
- Matériau : albedo `#ffd36e`, **Emission Enabled**, emission de la même couleur, énergie `2`.

Script `scripts/orbe.gd` :

```gdscript
extends Area3D

signal collected

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		queue_free()
```

C’est le script de l’étincelle 2D, avec `Node3D` à la place de `Node2D`.

## Compteur

Dans `monde.tscn` :

- `Node3D` nommé `Orbes`, trois instances, posées sur le sol (`Y = 0.35`) à des endroits accessibles.
- `CanvasLayer` → `Label` nommé `Score`, texte `Orbes : 0 / 3`, police 24.

`scripts/monde.gd` sur la racine :

```gdscript
extends Node3D

var ramasses := 0
var objectif := 3

@onready var score_label: Label = $CanvasLayer/Score

func _ready() -> void:
	for orbe in $Orbes.get_children():
		orbe.collected.connect(_on_orbe_collected)
	_rafraichir()

func _on_orbe_collected() -> void:
	ramasses += 1
	_rafraichir()

func _rafraichir() -> void:
	if ramasses >= objectif:
		score_label.text = "Le sanctuaire répond."
	else:
		score_label.text = "Orbes : %d / %d" % [ramasses, objectif]
```

`F5`. Traverse une orbe : elle disparaît, le texte change.

## Exercice

Monte le rayon de collision à `1.2` puis redescends à `0.6`. Tu sens la zone « aimant ». Pour un JRPG, une zone un peu plus grande que le dessin est souvent plus agréable qu’une collision pile sur les pixels.

## Bloqué ?

- L’orbe ne réagit pas : le joueur n’a pas le groupe `player`, ou `monitoring` est décoché sur l’`Area3D`.
- Elle disparaît au lancement : elle est dans la capsule. Décale-la de quelques mètres en X ou Z.
