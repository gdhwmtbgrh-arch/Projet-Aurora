# 07 — Score et défaite

## Objectif

Afficher le compteur à l’écran, un texte de victoire, et une défaite lisible avant le rechargement.

## Le HUD

L’interface ne doit pas défiler avec la caméra du monde. On la met dans un `CanvasLayer`.

Dans `main.tscn` :

1. Sous `Main`, ajoute `CanvasLayer`.
2. Enfant `Label`, nom `Score`. Position `(16, 16)`.
3. Inspecteur du label : **Theme Overrides → Font Sizes → Font Size** = `24`, couleur claire.
4. Texte de départ : `Étincelles : 0 / 3`.

## Brancher le script

`scripts/main.gd` :

```gdscript
extends Node2D

var etincelles := 0
var objectif := 3

@onready var score_label: Label = $CanvasLayer/Score

func _ready() -> void:
	_rafraichir()
	for enfant in $Etincelles.get_children():
		enfant.collected.connect(_on_etincelle_collected)

func _on_etincelle_collected() -> void:
	etincelles += 1
	_rafraichir()

func _rafraichir() -> void:
	if etincelles >= objectif:
		score_label.text = "La ruelle s'ouvre."
	else:
		score_label.text = "Étincelles : %d / %d" % [etincelles, objectif]
```

`@onready` attend que l’arbre existe avant de prendre le label. Sans ça, `$CanvasLayer/Score` peut être lu trop tôt.

`F5`. Le texte change quand tu ramasses.

## Défaite lisible

Dans `scripts/garde.gd`, remplace le rechargement immédiat :

```gdscript
func _on_contact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var main := get_tree().current_scene
		if main.has_method("defaite"):
			main.defaite()
```

Dans `main.gd`, ajoute :

```gdscript
var fini := false

func defaite() -> void:
	if fini:
		return
	fini = true
	score_label.text = "Le garde t'a vu. Réessaie."
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
```

Et au début de `_on_etincelle_collected` :

```gdscript
	if fini:
		return
```

Tu vois le message une seconde, puis la scène revient au début.

## Exercice

Si le compteur atteint l’objectif, passe `fini` à `true` pour ignorer le garde ensuite (la partie est déjà gagnée). Teste les deux fins : 3 étincelles, et un contact avant la troisième.

## Bloqué ?

- Le label défile avec le joueur : il n’est pas dans le `CanvasLayer`.
- Erreur sur `$CanvasLayer/Score` : le nom ou le parent ne correspond pas. Le chemin se lit dans l’arbre, de haut en bas.
- `await` souligné : la fonction doit rester sans type de retour, ou être déclarée `func defaite() -> void`. Les deux marchent ici.
