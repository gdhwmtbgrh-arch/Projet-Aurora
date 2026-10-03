# 05 — Ramasser avec un signal

## Objectif

Une étincelle disparaît quand le joueur la touche, et `Main` compte le ramassage sans que l’étincelle connaisse toute la scène.

## Scène Étincelle

1. Nouvelle scène, racine `Area2D`, nom `Etincelle`.
2. `Sprite2D` : texture `icon.svg`, **Scale** `0.12`, **Modulate** un jaune `#ffd36e`.
3. `CollisionShape2D`, `CircleShape2D`, rayon environ `16`.
4. Enregistre `scenes/etincelle.tscn`.
5. Script `scripts/etincelle.gd` sur la racine :

```gdscript
extends Area2D

signal collected

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		queue_free()
```

`Area2D` ne bloque pas. Il prévient. `body_entered` est un signal du moteur. `collected` est **ton** signal. `queue_free()` retire l’étincelle à la fin de l’image.

## Écouter depuis Main

Dans `main.tscn`, ajoute un `Node2D` nommé `Etincelles`. Glisse trois instances de `etincelle.tscn` **dedans**, à des endroits accessibles du couloir.

Remplace `scripts/main.gd` par :

```gdscript
extends Node2D

var etincelles := 0
var objectif := 3

func _ready() -> void:
	for enfant in $Etincelles.get_children():
		enfant.collected.connect(_on_etincelle_collected)
	print("Étincelles : %d / %d" % [etincelles, objectif])

func _on_etincelle_collected() -> void:
	etincelles += 1
	if etincelles >= objectif:
		print("Assez d'étincelles.")
	else:
		print("Étincelles : %d / %d" % [etincelles, objectif])
```

`$Etincelles` est un raccourci vers l’enfant qui porte ce nom. La boucle relie chaque étincelle à la même fonction.

`F5`. Marche sur une étincelle : elle disparaît, la sortie compte `1 / 3`.

## Pourquoi un signal

L’étincelle ne va pas chercher le score. Elle crie « collected ». `Main` décide quoi faire. Plus tard, le totem criera de la même façon, et un autoload rangera la sparkle.

## Exercice

Ajoute une quatrième étincelle. L’objectif reste 3 : le message de victoire arrive à la troisième, la quatrième peut encore être ramassée. Ensuite remets trois étincelles pour la suite du cours.

## Bloqué ?

- Rien ne se passe : le joueur n’est pas dans le groupe `player`, ou la collision de l’étincelle est trop petite.
- Erreur « collected does not exist » : le script n’est pas sur l’instance (il doit être sur la scène `etincelle.tscn`, pas recopié à la main sur chaque instance).
- L’étincelle disparaît au lancement : elle touche déjà le joueur. Écarte-la.
