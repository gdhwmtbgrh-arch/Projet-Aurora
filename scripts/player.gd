extends CharacterBody3D

## Personnage d'exploration : CharacterBody3D avec un Sprite3D billboard (HD-2D).
## Déplacement libre sur le plan XZ, aligné sur une caméra JRPG fixe en angle.

@export var speed: float = 4.5

@onready var sprite: Sprite3D = $Sprite3D
@onready var shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	_setup_shape()
	_setup_sprite()

func _setup_shape() -> void:
	var box := BoxShape3D.new()
	box.size = Vector3(0.6, 1.6, 0.6)
	shape.shape = box
	shape.position = Vector3(0, 0.8, 0)

func _setup_sprite() -> void:
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite.pixel_size = 0.02
	sprite.position = Vector3(0, 1.0, 0)
	sprite.shaded = false
	sprite.texture = _make_character_texture()

func _make_character_texture() -> ImageTexture:
	var w := 32
	var h := 48
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	var cloak := Color("#3f6fb0")
	var skin := Color("#f0c9a0")
	var hair := Color("#3a2b23")
	# Corps (cape).
	for y in range(20, 46):
		var half := 6 + int((y - 20) * 0.30)
		for x in range(16 - half, 16 + half):
			img.set_pixel(x, y, cloak)
	# Tête.
	for y in range(6, 20):
		for x in range(11, 21):
			var dx := x - 16
			var dy := y - 13
			if dx * dx + dy * dy <= 30:
				img.set_pixel(x, y, skin)
	# Cheveux.
	for y in range(5, 12):
		for x in range(10, 22):
			var dx2 := x - 16
			var dy2 := y - 11
			if dx2 * dx2 + dy2 * dy2 <= 34 and y <= 11:
				img.set_pixel(x, y, hair)
	return ImageTexture.create_from_image(img)

func _physics_process(_delta: float) -> void:
	var dir := Vector3.ZERO
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	if dir.length() > 1.0:
		dir = dir.normalized()
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed
	move_and_slide()
