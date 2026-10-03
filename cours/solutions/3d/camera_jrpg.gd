extends Camera3D

@export var cible: Node3D
@export var offset := Vector3(0, 9, 11)

func _process(_delta: float) -> void:
	if cible == null:
		return
	global_position = cible.global_position + offset
	look_at(cible.global_position + Vector3(0, 1, 0))
