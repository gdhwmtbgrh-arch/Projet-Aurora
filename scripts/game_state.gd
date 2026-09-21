extends Node

## Autoload global : configuration des entrées, inventaire de sparkles,
## sparkle équipée, et transitions de scène (exploration <-> combat).
## Volontairement minimal : socle du vertical slice, aucun système "déjà écrit".

signal sparkle_collected(sparkle: Sparkle)
signal sparkle_equipped(sparkle: Sparkle)

var inventory: Array[Sparkle] = []
var equipped: Sparkle = null

# Petit journal affiché à l'écran pour rendre le prototype lisible sans son/asset.
var last_message: String = ""

func _ready() -> void:
	_setup_input_map()

func _setup_input_map() -> void:
	_add_action("move_forward", [KEY_W, KEY_UP])
	_add_action("move_back", [KEY_S, KEY_DOWN])
	_add_action("move_left", [KEY_A, KEY_LEFT])
	_add_action("move_right", [KEY_D, KEY_RIGHT])
	_add_action("interact", [KEY_E, KEY_SPACE, KEY_ENTER])
	_add_action("attack", [KEY_1])
	_add_action("special", [KEY_2])
	_add_action("defend", [KEY_3])

func _add_action(action: String, keys: Array) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	for k in keys:
		var ev := InputEventKey.new()
		ev.physical_keycode = k
		InputMap.action_add_event(action, ev)

func collect_sparkle(sparkle: Sparkle) -> void:
	if sparkle == null:
		return
	inventory.append(sparkle)
	# Auto-équipe la première sparkle ramassée pour rendre le combat parlant.
	if equipped == null:
		equip(sparkle)
	last_message = "Sparkle obtenue : %s" % sparkle.describe()
	sparkle_collected.emit(sparkle)

func equip(sparkle: Sparkle) -> void:
	equipped = sparkle
	sparkle_equipped.emit(sparkle)

func has_sparkle() -> bool:
	return equipped != null

func goto_combat() -> void:
	get_tree().change_scene_to_file("res://scenes/Combat.tscn")

func goto_exploration() -> void:
	get_tree().change_scene_to_file("res://scenes/Exploration.tscn")
