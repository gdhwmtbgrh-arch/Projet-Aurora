extends Node2D

var etincelles := 0
var objectif := 3
var fini := false

@onready var score_label: Label = $CanvasLayer/Score

func _ready() -> void:
	_rafraichir()
	for enfant in $Etincelles.get_children():
		enfant.collected.connect(_on_etincelle_collected)

func _on_etincelle_collected() -> void:
	if fini:
		return
	etincelles += 1
	if etincelles >= objectif:
		fini = true
	_rafraichir()

func _rafraichir() -> void:
	if etincelles >= objectif:
		score_label.text = "La ruelle s'ouvre."
	else:
		score_label.text = "Étincelles : %d / %d" % [etincelles, objectif]

func defaite() -> void:
	if fini:
		return
	fini = true
	score_label.text = "Le garde t'a vu. Réessaie."
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
