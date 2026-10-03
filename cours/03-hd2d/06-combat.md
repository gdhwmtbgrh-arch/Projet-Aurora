# 06 — Combat au tour par tour

## Objectif

Quitter l’exploration, jouer un tour, revenir. L’intention utilise la sparkle du totem.

## Déclencher

Dans `monde.tscn`, un `Area3D` nommé `Rencontre`, sphère de rayon `1.5`, posé sur le chemin. Script `scripts/rencontre.gd` :

```gdscript
extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GameState.vers_combat()
```

Dès que tu marches dedans, la scène change. Place cette zone **après** le totem sur le chemin, pour pouvoir prendre la sparkle d’abord.

## Scène `scenes/combat.tscn`

Racine `Control`, ancrée en plein écran (preset **Full Rect**). Nom `Combat`.

Enfants :

- `ColorRect` nommé `Fond`, ancré en plein écran, couleur `#0b0e1a`.
- `Label` nommé `Journal`, position `(40, 80)`, taille de police 22.
- `Label` nommé `PV`, position `(40, 40)`, police 28.
- `HBoxContainer` nommé `Actions`, position `(40, 560)`.
  - Bouton `Attaquer`, texte `1  Attaquer`, taille mini 220×48.
  - Bouton `Intention`.
  - Bouton `Garde`, texte `3  Garde`.

Script `scripts/combat.gd` :

```gdscript
extends Control

var pv_elora := 30
var pv_garde := 24
var garde := false
var tour_joueur := true
var fini := false

@onready var journal: Label = $Journal
@onready var pv: Label = $PV
@onready var bouton_intention: Button = $Actions/Intention

func _ready() -> void:
	$Actions/Attaquer.pressed.connect(_attaquer)
	bouton_intention.pressed.connect(_intention)
	$Actions/Garde.pressed.connect(_defendre)
	if GameState.a_une_sparkle():
		bouton_intention.text = "2  " + GameState.sparkle_intention
	else:
		bouton_intention.text = "2  Intention"
		bouton_intention.disabled = true
	_dire("Un garde bloque le passage.")
	_rafraichir()

func _attaquer() -> void:
	if not _peut_jouer():
		return
	var degats := 7 + randi() % 4
	pv_garde = max(0, pv_garde - degats)
	_dire("Elora attaque : %d." % degats)
	_suite()

func _intention() -> void:
	if not _peut_jouer() or not GameState.a_une_sparkle():
		return
	var degats := 7 + GameState.bonus + randi() % 4
	pv_garde = max(0, pv_garde - degats)
	_dire("Intention %s : %d." % [GameState.sparkle_intention, degats])
	_suite()

func _defendre() -> void:
	if not _peut_jouer():
		return
	garde = true
	_dire("Elora se couvre.")
	_suite()

func _peut_jouer() -> bool:
	return tour_joueur and not fini

func _suite() -> void:
	tour_joueur = false
	_rafraichir()
	if pv_garde <= 0:
		_finir(true)
		return
	await get_tree().create_timer(0.5).timeout
	var degats := 6 + randi() % 3
	if garde:
		degats = int(degats / 2.0)
		garde = false
	pv_elora = max(0, pv_elora - degats)
	_dire("Le garde riposte : %d." % degats)
	if pv_elora <= 0:
		_finir(false)
		return
	tour_joueur = true
	_rafraichir()

func _finir(victoire: bool) -> void:
	fini = true
	tour_joueur = false
	if victoire:
		_dire("Le passage est libre. [E] pour revenir.")
	else:
		_dire("Elora tombe. [E] pour revenir.")
	_rafraichir()

func _dire(ligne: String) -> void:
	journal.text = ligne

func _rafraichir() -> void:
	pv.text = "Elora %d    Garde %d" % [pv_elora, pv_garde]
	var bloque := fini or not tour_joueur
	$Actions/Attaquer.disabled = bloque
	$Actions/Garde.disabled = bloque
	bouton_intention.disabled = bloque or not GameState.a_une_sparkle()

func _unhandled_input(event: InputEvent) -> void:
	if fini and event.is_action_pressed("interact"):
		GameState.vers_monde()
```

Scène principale du projet : `monde.tscn` (pas le combat). `F5`.

Parcours : totem, `E`, puis la zone de rencontre. Sans sparkle, Intention est grisé et l’attaque fait moins mal. Avec la sparkle, Intention dépasse l’attaque. Après la victoire, `E` revient dans la cour. Le totem se souvient, parce que `GameState` a gardé `totem_donne`.

## Limite assumée

Le combat est une interface plate. L’exploration est HD-2D. Les mettre dans le même style (sprites 3D face à face, lumière de sort) est l’étape d’après, pas celle-ci. D’abord la règle : un tour, trois actions, une intention qui dépend de la sparkle.

## Exercice

Perds exprès, reviens, reprends la sparkle (elle doit encore être là) et gagne. Si la sparkle a disparu, elle était stockée sur le totem au lieu de `GameState`.

## Bloqué ?

- La rencontre relance le combat en boucle au retour : la zone est sur le point d’apparition du joueur. Décale-la.
- Les boutons ne répondent pas : ils ne s’appellent pas `Attaquer`, `Intention`, `Garde`, ou ils ne sont pas dans `Actions`.
- `await` dans `_suite` : la fonction ne doit pas être typée `-> void` si ta version de Godot râle… En Godot 4, `func _suite() -> void` accepte `await`. Laisse le type.
