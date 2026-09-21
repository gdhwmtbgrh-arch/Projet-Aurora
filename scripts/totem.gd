extends Area3D

## Borne-totem (stub). Quand le joueur est à proximité et interagit,
## elle offre une sparkle équipable liée à sa vertu.

@export var totem_nom: String = "Ours"
@export var vertu: String = "Courage"
@export var couleur: Color = Color("#c0562e")
@export var intention: int = 0  # Sparkle.Intention

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var shape: CollisionShape3D = $CollisionShape3D
@onready var label: Label3D = $Label3D

var _player_in_range := false
var _given := false

func _ready() -> void:
	_build_pillar()
	_build_label()
	var s := SphereShape3D.new()
	s.radius = 2.2
	shape.shape = s
	shape.position = Vector3(0, 1.0, 0)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _build_pillar() -> void:
	var box := BoxMesh.new()
	box.size = Vector3(0.8, 2.0, 0.8)
	mesh.mesh = box
	mesh.position = Vector3(0, 1.0, 0)
	var mat := StandardMaterial3D.new()
	mat.albedo_color = couleur
	mat.emission_enabled = true
	mat.emission = couleur
	mat.emission_energy_multiplier = 1.4
	mesh.material_override = mat

func _build_label() -> void:
	label.text = "%s\n%s" % [totem_nom, vertu]
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	label.position = Vector3(0, 2.6, 0)
	label.modulate = Color("#e8e6df")
	label.outline_modulate = Color(0, 0, 0, 1)
	label.font_size = 48
	label.pixel_size = 0.006

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		_player_in_range = true
		_refresh_prompt()

func _on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		_player_in_range = false
		_refresh_prompt()

func _refresh_prompt() -> void:
	if _given:
		label.text = "%s\n%s ✓" % [totem_nom, vertu]
	elif _player_in_range:
		label.text = "%s\n[E] recueillir la sparkle" % totem_nom
	else:
		label.text = "%s\n%s" % [totem_nom, vertu]

func _unhandled_input(event: InputEvent) -> void:
	if _given or not _player_in_range:
		return
	if event.is_action_pressed("interact"):
		_give_sparkle()

func _give_sparkle() -> void:
	_given = true
	var sp := Sparkle.new()
	sp.nom = "Sparkle du %s" % totem_nom
	sp.totem = totem_nom
	sp.intention = intention
	sp.couleur = couleur
	sp.bonus_degats = 8
	GameState.collect_sparkle(sp)
	_refresh_prompt()
