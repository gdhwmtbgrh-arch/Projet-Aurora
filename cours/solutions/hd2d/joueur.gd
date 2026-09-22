extends CharacterBody3D

@export var speed := 4.0
var gravity := 9.8

@onready var sprite: Sprite3D = $Sprite3D

func _ready() -> void:
	sprite.centered = true
	sprite.position = Vector3(0, 1.0, 0)
	sprite.pixel_size = 0.045
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
	sprite.shaded = true
	sprite.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	sprite.texture = _dessin()

func _dessin() -> ImageTexture:
	var img := Image.create(32, 48, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	var cape := Color("#3f6fb0")
	var peau := Color("#f0c9a0")
	var cheveux := Color("#2a2420")
	for y in range(18, 46):
		var demi := 5 + int((y - 18) / 6.0)
		for x in range(16 - demi, 16 + demi):
			img.set_pixel(x, y, cape)
	for y in range(8, 18):
		for x in range(12, 20):
			img.set_pixel(x, y, peau)
	for x in range(11, 21):
		for y in range(6, 12):
			img.set_pixel(x, y, cheveux)
	return ImageTexture.create_from_image(img)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(input.x, 0.0, input.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
