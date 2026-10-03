# 02 — Pixels nets

## Objectif

Afficher une image pixelisée sans que Godot la floute.

## Pourquoi ça bave

Par défaut, Godot adoucit les textures quand elles sont agrandies. Sur une photo, c’est bien. Sur du pixel art, chaque carré doit rester un carré. Le filtre s’appelle **Nearest** (le plus proche).

## Une texture de sol

Dans le projet `AuroraSlice` (copie de la scène 3D, ou scène neuve `Node3D`), crée `scripts/textures_pixel.gd`. Ce fichier ne se pose pas sur un nœud : c’est une collection de fonctions. On s’en sert avec `preload`.

```gdscript
extends RefCounted
class_name TexturesPixel

static func damier(a: Color, b: Color) -> ImageTexture:
	var taille := 16
	var img := Image.create(taille, taille, false, Image.FORMAT_RGBA8)
	for y in taille:
		for x in taille:
			var case_claire := ((x / 4) + (y / 4)) % 2 == 0
			img.set_pixel(x, y, a if case_claire else b)
	return ImageTexture.create_from_image(img)
```

`class_name` permet d’écrire `TexturesPixel.damier(...)` partout après un rechargement du projet.

Sur le matériau du sol (`StandardMaterial3D`) :

- **Albedo Texture** : on va l’assigner par script au démarrage, c’est plus simple que d’enregistrer un fichier.
- **Texture Filter** : **Nearest**.
- **UV1 Scale** : `(20, 20, 1)` pour répéter le damier.

Script sur `Monde`, le temps de brancher le sol (tu le complèteras ensuite) :

```gdscript
func _ready() -> void:
	var mat := $Sol.material_override as StandardMaterial3D
	if mat == null:
		mat = StandardMaterial3D.new()
		$Sol.material_override = mat
	mat.albedo_texture = TexturesPixel.damier(Color("#3c6b43"), Color("#325c3a"))
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mat.uv1_scale = Vector3(20, 20, 1)
```

`F6`. Le sol est un damier de gros pixels, pas un vert lisse.

## Remplacer plus tard par un vrai dessin

1. Dessine un PNG (Piskel dans le navigateur, ou un autre outil que tu as le droit d’ouvrir).
2. Taille multiple de 2 : 16, 32, 64.
3. Glisse le PNG dans `art/`.
4. Dans l’inspecteur du matériau, assigne cette texture à la place du damier.
5. Laisse **Nearest**.

Si tu oublies Nearest, le dessin devient flou dès que la caméra bouge. C’est l’erreur la plus fréquente du HD-2D dans Godot.

## Exercice

Change les deux verts pour un brun de chemin `#6b5344` / `#5a4638`. Relance. Le gameplay ne change pas, seulement la lecture du sol.

## Bloqué ?

- `TexturesPixel` inconnu : enregistre le script, attends une seconde, ou **Projet → Recharger le projet**. `class_name` n’est pas visible à la milliseconde où tu crées le fichier.
- Le damier est étiré en longues bandes : `UV1 Scale` est resté à `(1, 1, 1)`.
