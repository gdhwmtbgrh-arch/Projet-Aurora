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
