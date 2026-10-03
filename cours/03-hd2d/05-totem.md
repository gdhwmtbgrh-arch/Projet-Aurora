# 05 — Le totem et la sparkle

## Objectif

Appuyer sur `E` devant un totem pour obtenir une sparkle qui survit au changement de scène.

## La touche

Projet → Paramètres du projet → **Contrôles** → **Ajouter une action** `interact`. Associe la touche `E`.

Les flèches restent `ui_up`, `ui_down`, `ui_left`, `ui_right`.

## Autoload

`scripts/game_state.gd` :

```gdscript
extends Node

var totem_donne := false
var sparkle_nom := ""
var sparkle_intention := ""
var bonus := 0

func a_une_sparkle() -> bool:
	return sparkle_nom != ""

func equiper(nom: String, intention: String, bonus_degats: int) -> void:
	sparkle_nom = nom
	sparkle_intention = intention
	bonus = bonus_degats

func vers_combat() -> void:
	get_tree().change_scene_to_file("res://scenes/combat.tscn")

func vers_monde() -> void:
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
```

Paramètres du projet → **Autoload** → fichier `game_state.gd` → nom `GameState` → **Ajouter**.

Un autoload n’est pas détruit quand tu changes de scène. La position d’Elora, elle, revient au départ : elle vit dans la scène. La sparkle vit dans `GameState`.

## Scène `scenes/totem.tscn`

Racine `Area3D`.

- `MeshInstance3D`, `BoxMesh` `(0.8, 2.0, 0.8)`, position Y `1`.
- Matériau albedo et émission `#c0562e`, énergie d’émission `2`.
- `CollisionShape3D`, `SphereShape3D` rayon `2.2`, position Y `1`.
- `Label3D`, texte `Ours`, billboard activé, position Y `2.4`, pixel size `0.01`.

Script `scripts/totem.gd` :

```gdscript
extends Area3D

var joueur_proche := false

@onready var label: Label3D = $Label3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_rafraichir()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		joueur_proche = true
		_rafraichir()

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		joueur_proche = false
		_rafraichir()

func _unhandled_input(event: InputEvent) -> void:
	if not joueur_proche or GameState.totem_donne:
		return
	if event.is_action_pressed("interact"):
		GameState.totem_donne = true
		GameState.equiper("Sparkle de l'Ours", "Courage", 8)
		_rafraichir()

func _rafraichir() -> void:
	if GameState.totem_donne:
		label.text = "Ours\nCourage"
	elif joueur_proche:
		label.text = "Ours\n[E] sparkle"
	else:
		label.text = "Ours"
```

Place le totem dans la cour, pas dans un mur. `F5`. Approche-toi : le texte change. `E` : la sparkle est équipée. Éloigne-toi et reviens : elle ne se redonne pas.

## Les quatre totems, plus tard

Le cours n’en pose qu’un. Les trois autres (Hibou / Connaissance, Cerf / Partage, Panthère / Instinct) sont le même prefab avec un autre nom, une autre couleur, une autre intention. Ne copie pas quatre scripts. Ajoute `@export var nom_totem`, `@export var intention`, `@export var couleur` quand tu voudras les dupliquer.

## Exercice

Dans la sortie (`print` dans `_unhandled_input`), affiche `GameState.sparkle_nom` après `E`. Tu dois lire `Sparkle de l'Ours`.

## Bloqué ?

- `E` ne fait rien : l’action `interact` n’existe pas, ou le joueur n’entre pas dans la sphère (groupe `player` manquant).
- `GameState` inconnu : l’autoload n’est pas ajouté, ou le nom a une faute.
- Le label est minuscule ou géant : ajuste `pixel_size` entre `0.005` et `0.02`.
