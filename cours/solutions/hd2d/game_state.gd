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
