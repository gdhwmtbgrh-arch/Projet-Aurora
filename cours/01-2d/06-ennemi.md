# 06 — Un garde qui patrouille

## Objectif

Un personnage contrôlé par le script, qui fait demi-tour contre les murs, et qui fait recommencer la partie s’il touche le joueur.

## Scène Garde

1. Racine `CharacterBody2D`, nom `Garde`. Groupe : `guard`.
2. `Sprite2D` : `icon.svg`, scale `0.2`, modulate `#8a2f3b`.
3. `CollisionShape2D`, rectangle un peu plus petit que le sprite.
4. Enfant `Area2D` nommé `Contact`, avec son propre `CollisionShape2D` (cercle, rayon ~20). Cette zone détecte le joueur. Le rectangle du corps, lui, bloque contre les murs.
5. `scenes/garde.tscn`, script `scripts/garde.gd` :

```gdscript
extends CharacterBody2D

@export var speed := 90.0
var sens := 1.0

func _ready() -> void:
	$Contact.body_entered.connect(_on_contact_body_entered)

func _physics_process(_delta: float) -> void:
	velocity = Vector2(speed * sens, 0.0)
	move_and_slide()
	if is_on_wall():
		sens *= -1.0

func _on_contact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
```

`is_on_wall()` est vrai après `move_and_slide()` si le corps a touché un mur sur le côté.

## Le poser

Dans `main.tscn`, instance `garde.tscn` dans un couloir **horizontal** assez long, pas collé à un mur. `F5`.

Il va à droite, rebondit, revient. Si tu le touches, la scène recharge : les étincelles reviennent, le score aussi (il est dans la scène, pas encore sauvegardé ailleurs).

## Exercice

Ajoute `@export var sens_depart := 1.0` et, dans `_ready`, fais `sens = sens_depart`. Sur l’instance dans `Main`, mets `-1` : le garde part vers la gauche.

## Bloqué ?

- Il ne rebondit pas et tremble : il est coincé dans un mur, ou le couloir est vertical alors que la vitesse est seulement en X. Laisse un couloir gauche-droite plus large que le garde.
- Il ne te détecte pas : le `CollisionShape2D` est sur le corps mais pas sur `Contact`, ou la connexion `$Contact` échoue parce que le nœud n’a pas ce nom exact.
- La scène recharge en boucle : le joueur commence dans la zone de contact. Éloigne le point d’apparition.
