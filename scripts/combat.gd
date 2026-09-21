extends Control

## Combat tour par tour minimal : 1 héros vs 1 ennemi.
## L'action "Intention" utilise la sparkle équipée (stub de combo d'équipe).
## L'interface est construite par code pour rester robuste et sans asset.

var player_hp := 30
var player_hp_max := 30
var player_atk := 8

var enemy_hp := 28
var enemy_hp_max := 28
var enemy_atk := 7

var _defending := false
var _player_turn := true
var _over := false
var _log: Array[String] = []

var _title: Label
var _player_bar: Label
var _enemy_bar: Label
var _log_label: Label
var _btn_attack: Button
var _btn_special: Button
var _btn_defend: Button

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	_build_ui()
	_push("Un combat s'engage !")
	if GameState.has_sparkle():
		_push("Sparkle équipée : %s" % GameState.equipped.describe())
	_refresh()

func _build_ui() -> void:
	var bg := ColorRect.new()
	bg.color = Color("#0b0e1a")
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	_title = _make_label(Vector2(40, 28), 30, Color("#ffd36e"))
	_title.text = "Combat — Sentinelle du sanctuaire"
	add_child(_title)

	# Combattants (silhouettes simples générées par code).
	_add_fighter(Vector2(220, 150), Color("#3f6fb0"))
	_add_fighter(Vector2(900, 150), Color("#8a2f3b"))

	_player_bar = _make_label(Vector2(160, 340), 22, Color("#e8e6df"))
	add_child(_player_bar)
	_enemy_bar = _make_label(Vector2(860, 340), 22, Color("#e8e6df"))
	add_child(_enemy_bar)

	var log_bg := ColorRect.new()
	log_bg.color = Color(0, 0, 0, 0.35)
	log_bg.position = Vector2(40, 430)
	log_bg.size = Vector2(1200, 180)
	add_child(log_bg)
	_log_label = _make_label(Vector2(56, 442), 18, Color("#c8d0e4"))
	add_child(_log_label)

	var actions := HBoxContainer.new()
	actions.position = Vector2(40, 630)
	actions.add_theme_constant_override("separation", 16)
	add_child(actions)
	_btn_attack = _make_button("1 · Attaquer")
	_btn_special = _make_button("2 · Intention")
	_btn_defend = _make_button("3 · Garde")
	actions.add_child(_btn_attack)
	actions.add_child(_btn_special)
	actions.add_child(_btn_defend)
	_btn_attack.pressed.connect(_on_attack)
	_btn_special.pressed.connect(_on_special)
	_btn_defend.pressed.connect(_on_defend)
	if GameState.has_sparkle():
		_btn_special.text = "2 · Intention : %s" % GameState.equipped.intention_nom()
	else:
		_btn_special.text = "2 · Intention (aucune sparkle)"

func _make_label(pos: Vector2, size: int, color: Color) -> Label:
	var l := Label.new()
	l.position = pos
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	l.add_theme_color_override("font_outline_color", Color(0, 0, 0, 1))
	l.add_theme_constant_override("outline_size", 6)
	return l

func _make_button(text: String) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(240, 56)
	b.add_theme_font_size_override("font_size", 22)
	return b

func _add_fighter(pos: Vector2, color: Color) -> void:
	var rect := ColorRect.new()
	rect.color = color
	rect.position = pos
	rect.size = Vector2(160, 180)
	add_child(rect)
	var head := ColorRect.new()
	head.color = Color("#f0c9a0")
	head.position = pos + Vector2(50, -40)
	head.size = Vector2(60, 60)
	add_child(head)

func _push(line: String) -> void:
	_log.append(line)
	if _log.size() > 8:
		_log = _log.slice(_log.size() - 8)

func _refresh() -> void:
	_player_bar.text = "Kael\nPV %d / %d" % [player_hp, player_hp_max]
	_enemy_bar.text = "Sentinelle\nPV %d / %d" % [enemy_hp, enemy_hp_max]
	_log_label.text = "\n".join(_log)
	var lock := _over or not _player_turn
	_btn_attack.disabled = lock
	_btn_defend.disabled = lock
	_btn_special.disabled = lock or not GameState.has_sparkle()

func _on_attack() -> void:
	if _over or not _player_turn:
		return
	var dmg := player_atk + randi() % 4
	enemy_hp = max(0, enemy_hp - dmg)
	_push("Kael attaque : %d dgt." % dmg)
	_after_player_action()

func _on_special() -> void:
	if _over or not _player_turn or not GameState.has_sparkle():
		return
	var sp: Sparkle = GameState.equipped
	var dmg := player_atk + sp.bonus_degats + randi() % 4
	enemy_hp = max(0, enemy_hp - dmg)
	_push("Kael canalise l'intention %s (%s) : %d dgt !" % [sp.intention_nom(), sp.totem, dmg])
	_after_player_action()

func _on_defend() -> void:
	if _over or not _player_turn:
		return
	_defending = true
	_push("Kael se met en garde.")
	_after_player_action()

func _after_player_action() -> void:
	_player_turn = false
	_refresh()
	if enemy_hp <= 0:
		_end(true)
		return
	await get_tree().create_timer(0.6).timeout
	_enemy_action()

func _enemy_action() -> void:
	if _over:
		return
	var dmg := enemy_atk + randi() % 3
	if _defending:
		dmg = int(dmg / 2.0)
		_defending = false
	player_hp = max(0, player_hp - dmg)
	_push("La Sentinelle riposte : %d dgt." % dmg)
	if player_hp <= 0:
		_end(false)
		return
	_player_turn = true
	_refresh()

func _end(victory: bool) -> void:
	_over = true
	if victory:
		_push("Victoire ! La Sentinelle s'effondre.")
	else:
		_push("Défaite… Kael tombe à genoux.")
	_push("[E] retour à l'exploration")
	_refresh()

func _unhandled_input(event: InputEvent) -> void:
	if _over:
		if event.is_action_pressed("interact"):
			GameState.last_message = "Retour de combat."
			GameState.goto_exploration()
		return
	if not _player_turn:
		return
	if event.is_action_pressed("attack"):
		_on_attack()
	elif event.is_action_pressed("special"):
		_on_special()
	elif event.is_action_pressed("defend"):
		_on_defend()
