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
