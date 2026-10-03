# 03 — Le personnage en Sprite3D

## Objectif

Remplacer la capsule par un sprite pixel qui regarde toujours la caméra.

## Scène

Dans `scenes/joueur.tscn` :

1. Supprime le `MeshInstance3D` de la capsule (garde le `CharacterBody3D` et le `CollisionShape3D`).
2. Ajoute un enfant `Sprite3D`.
3. Garde la capsule de collision : rayon `0.3`, hauteur `1.4`, position Y `0.7`. Le sprite est l’image. La capsule est le corps qui touche les murs. Ils ne sont pas obligés d’avoir la même forme, mais ils doivent occuper le même endroit au sol.

## Script `scripts/joueur.gd`

```gdscript
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
```

## Ce que chaque ligne change

- `billboard` : le dessin fait face à la caméra. Sans ça, tu vois le sprite de profil, plat comme une pancarte.
- `pixel_size` : taille d’un pixel en mètres. Trop petit, Elora est une fourmi. Trop grand, elle dépasse les maisons.
- `ALPHA_CUT_OPAQUE_PREPASS` : les pixels transparents du PNG ne bavent pas dans le flou de profondeur.
- `shaded` : la lumière du soleil teinte la cape. Décoche-le si tu veux des couleurs « brutes », comme un sprite de Game Boy posé dans un décor.
- `cast_shadow` : une ombre au sol. C’est souvent ce qui fait « rentrer » le personnage dans le monde.

`F5`. Tu dois voir un petit personnage bleu, net, qui tourne toujours sa face vers toi quand la caméra le suit.

## Exercice

Remplace la cape `#3f6fb0` par une autre couleur, relance, puis reviens au bleu. Ensuite dessine un PNG 32×48 dans `art/elora.png` (même une silhouette) et, dans `_ready`, remplace `sprite.texture = _dessin()` par :

```gdscript
	sprite.texture = load("res://art/elora.png")
```

Nearest reste obligatoire.

## Bloqué ?

- Carré blanc : la texture est vide ou le chemin du PNG est faux.
- Le sprite est flou : `texture_filter` n’est pas Nearest.
- Il traverse les murs : la `CollisionShape3D` a été supprimée avec la capsule visuelle. Remets-la.
- Il est couché au sol : `billboard` est désactivé et la rotation X du sprite est à 0. Active le billboard plutôt que de tourner le sprite à la main.
