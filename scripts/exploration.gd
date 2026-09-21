extends Node3D

## Scène d'exploration HD-2D (construite par code, sans asset binaire) :
## monde 3D low-poly texturé "pixel", perso Sprite3D billboard, caméra JRPG en
## angle, lumière directionnelle, bloom + DOF + brouillard.

const PlayerScene := preload("res://scenes/Player.tscn")
const TotemScene := preload("res://scenes/Totem.tscn")

var _player: CharacterBody3D
var _encounter: Area3D
var _encounter_in_range := false
var _hud: Label

func _ready() -> void:
	_build_environment()
	_build_light()
	_build_ground()
	_build_props()
	_build_camera()
	_spawn_player()
	_spawn_totem()
	_spawn_encounter()
	_build_hud()

func _build_environment() -> void:
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color("#141a2e")
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color("#5b6b93")
	env.ambient_light_energy = 0.6
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	# Bloom (HD-2D).
	env.glow_enabled = true
	env.glow_intensity = 0.9
	env.glow_bloom = 0.25
	# Brouillard (profondeur du diorama).
	env.fog_enabled = true
	env.fog_light_color = Color("#243056")
	env.fog_density = 0.02
	var we := WorldEnvironment.new()
	we.environment = env
	add_child(we)

func _build_light() -> void:
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55, -50, 0)
	sun.light_energy = 1.3
	sun.light_color = Color("#fff2d6")
	sun.shadow_enabled = true
	add_child(sun)

func _build_ground() -> void:
	var plane := PlaneMesh.new()
	plane.size = Vector2(40, 40)
	var mi := MeshInstance3D.new()
	mi.mesh = plane
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = _make_pixel_tile(Color("#3c6b43"), Color("#325c3a"))
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mat.uv1_scale = Vector3(20, 20, 1)
	mi.material_override = mat
	add_child(mi)

func _make_pixel_tile(a: Color, b: Color) -> ImageTexture:
	# Petite tuile "pixel" (damier) filtrée en nearest pour le look HD-2D.
	var size := 16
	var img := Image.create(size, size, false, Image.FORMAT_RGBA8)
	for y in range(size):
		for x in range(size):
			var checker := ((x / 4) + (y / 4)) % 2 == 0
			img.set_pixel(x, y, a if checker else b)
	return ImageTexture.create_from_image(img)

func _build_props() -> void:
	# Blocs low-poly (arbres/rochers stylisés) autour de l'aire de jeu.
	var rng := RandomNumberGenerator.new()
	rng.seed = 20260921
	for i in range(14):
		var block := MeshInstance3D.new()
		var bm := BoxMesh.new()
		var height := rng.randf_range(1.0, 3.0)
		bm.size = Vector3(rng.randf_range(0.8, 1.6), height, rng.randf_range(0.8, 1.6))
		block.mesh = bm
		var mat := StandardMaterial3D.new()
		var tone := rng.randf_range(0.25, 0.5)
		mat.albedo_color = Color(tone * 0.5, tone, tone * 0.4)
		block.material_override = mat
		var angle := rng.randf_range(0, TAU)
		var radius := rng.randf_range(8.0, 16.0)
		block.position = Vector3(cos(angle) * radius, height * 0.5, sin(angle) * radius)
		add_child(block)

func _build_camera() -> void:
	var cam := Camera3D.new()
	cam.projection = Camera3D.PROJECTION_PERSPECTIVE
	cam.fov = 42.0
	cam.position = Vector3(0, 9.5, 10.5)
	cam.look_at_from_position(cam.position, Vector3(0, 1.0, 0), Vector3.UP)
	# DOF (profondeur de champ) pour le rendu HD-2D.
	var attrs := CameraAttributesPractical.new()
	attrs.dof_blur_far_enabled = true
	attrs.dof_blur_far_distance = 18.0
	attrs.dof_blur_far_transition = 6.0
	attrs.dof_blur_amount = 0.08
	cam.attributes = attrs
	add_child(cam)

func _spawn_player() -> void:
	_player = PlayerScene.instantiate()
	_player.position = Vector3(0, 0, 2)
	add_child(_player)

func _spawn_totem() -> void:
	var totem := TotemScene.instantiate()
	totem.totem_nom = "Ours"
	totem.vertu = "Courage"
	totem.couleur = Color("#c0562e")
	totem.intention = 0
	totem.position = Vector3(-4, 0, -3)
	add_child(totem)

func _spawn_encounter() -> void:
	_encounter = Area3D.new()
	_encounter.position = Vector3(4.5, 0, -3)
	var mesh := MeshInstance3D.new()
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.5
	capsule.height = 1.8
	mesh.mesh = capsule
	mesh.position = Vector3(0, 1.0, 0)
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color("#8a2f3b")
	mat.emission_enabled = true
	mat.emission = Color("#c0393f")
	mat.emission_energy_multiplier = 1.2
	mesh.material_override = mat
	_encounter.add_child(mesh)
	var label := Label3D.new()
	label.text = "Sentinelle\n[E] engager le combat"
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	label.position = Vector3(0, 2.6, 0)
	label.font_size = 48
	label.pixel_size = 0.006
	label.outline_modulate = Color(0, 0, 0, 1)
	_encounter.add_child(label)
	var col := CollisionShape3D.new()
	var s := SphereShape3D.new()
	s.radius = 2.2
	col.shape = s
	col.position = Vector3(0, 1.0, 0)
	_encounter.add_child(col)
	_encounter.body_entered.connect(func(b): if b is CharacterBody3D: _encounter_in_range = true)
	_encounter.body_exited.connect(func(b): if b is CharacterBody3D: _encounter_in_range = false)
	add_child(_encounter)

func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	_hud = Label.new()
	_hud.position = Vector2(24, 20)
	_hud.add_theme_font_size_override("font_size", 20)
	_hud.add_theme_color_override("font_color", Color("#e8e6df"))
	_hud.add_theme_color_override("font_outline_color", Color(0, 0, 0, 1))
	_hud.add_theme_constant_override("outline_size", 6)
	layer.add_child(_hud)
	_update_hud()

func _process(_delta: float) -> void:
	_update_hud()

func _update_hud() -> void:
	if _hud == null:
		return
	var equip := "aucune"
	if GameState.has_sparkle():
		equip = GameState.equipped.describe()
	var lines := [
		"PROJET-AURORA — prototype HD-2D (Godot 4)",
		"Déplacement : ZQSD / flèches   ·   Interagir : E",
		"Sparkle équipée : %s" % equip,
	]
	if GameState.last_message != "":
		lines.append("» %s" % GameState.last_message)
	_hud.text = "\n".join(lines)

func _unhandled_input(event: InputEvent) -> void:
	if _encounter_in_range and event.is_action_pressed("interact"):
		GameState.goto_combat()
