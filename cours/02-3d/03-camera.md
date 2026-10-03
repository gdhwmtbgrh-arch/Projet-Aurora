# 03 — Caméra en plongée

## Objectif

Une caméra qui suit le joueur depuis en haut et en arrière, comme dans un JRPG, pas une caméra à la première personne.

## Scène `scenes/camera_jrpg.tscn`

Racine `Camera3D`, nom `CameraJRPG`. Script `scripts/camera_jrpg.gd` :

```gdscript
extends Camera3D

@export var cible: Node3D
@export var offset := Vector3(0, 9, 11)

func _process(_delta: float) -> void:
	if cible == null:
		return
	global_position = cible.global_position + offset
	look_at(cible.global_position + Vector3(0, 1, 0))
```

`offset` place la caméra 9 m au-dessus et 11 m « derrière » sur Z. `look_at` vise la poitrine du personnage, pas ses pieds.

**Current** doit être coché sur la `Camera3D`, sinon Godot ignore cette caméra.

## Brancher

1. Instance `camera_jrpg.tscn` dans `monde.tscn`.
2. Sélectionne l’instance. Le champ **Cible** : choisis le nœud `Joueur` (petite icône Assigner).
3. `F5`.

Tu vois le sol, le poteau, la capsule. Les flèches la déplacent et la caméra suit sans tourner autour d’elle. C’est voulu : dans un JRPG en vue fixe, le haut de l’écran reste le « nord » de la scène.

## Exercice

Essaie `offset = (0, 4, 6)` puis reviens à `(0, 9, 11)`. Note ce qui change : plus l’offset Y est petit, plus tu es près du sol et plus l’horizon monte.

## Bloqué ?

- Écran gris ou bleu vide : **Current** n’est pas coché, ou la cible n’est pas assignée et la caméra reste à l’origine en regardant ailleurs.
- La caméra tourne dans tous les sens : tu as mis la caméra **enfant** du joueur et tu la déplaces en plus dans le script. Laisse-la à la racine du monde. Le script suffit.
- `look_at` provoque une erreur : la caméra est exactement sur le point visé. Garde un offset non nul.
