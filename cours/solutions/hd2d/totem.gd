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
