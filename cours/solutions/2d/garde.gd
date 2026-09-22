extends CharacterBody2D

@export var speed := 90.0
@export var sens_depart := 1.0
var sens := 1.0

func _ready() -> void:
	sens = sens_depart
	$Contact.body_entered.connect(_on_contact_body_entered)

func _physics_process(_delta: float) -> void:
	velocity = Vector2(speed * sens, 0.0)
	move_and_slide()
	if is_on_wall():
		sens *= -1.0

func _on_contact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var main := get_tree().current_scene
		if main.has_method("defaite"):
			main.defaite()
