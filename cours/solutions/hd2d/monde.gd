extends Node3D

func _ready() -> void:
	var mat := $Sol.material_override as StandardMaterial3D
	if mat == null:
		mat = StandardMaterial3D.new()
		$Sol.material_override = mat
	mat.albedo_texture = TexturesPixel.damier(Color("#3c6b43"), Color("#325c3a"))
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mat.uv1_scale = Vector3(20, 20, 1)
