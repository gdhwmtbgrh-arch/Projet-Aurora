# 02 — Le minimum de GDScript

## Objectif

Attacher un script et comprendre quatre idées : variable, fonction, condition, signal. Tu n’as pas besoin de tout le langage pour finir ce cours.

## Attacher un script

1. Sélectionne `Main`.
2. Clique l’icône de parchemin (Attacher un script).
3. Chemin : `res://scripts/main.gd`.
4. Modèle : vide. Crée.

Godot écrit un squelette. Remplace-le par :

```gdscript
extends Node2D

var etincelles := 0

func _ready() -> void:
	print("La ruelle s'ouvre. Étincelles : ", etincelles)

func ajouter_etincelle() -> void:
	etincelles += 1
	print("Étincelles : ", etincelles)
```

## Lancer et lire

`F6`. En bas, onglet **Sortie** : tu dois lire `La ruelle s'ouvre. Étincelles : 0`.

- `_ready()` est appelée **une fois**, quand le nœud entre en jeu.
- `_process(delta)` est appelée **chaque image**. On ne s’en sert pas encore.
- `_physics_process(delta)` est appelée à rythme fixe. Le mouvement du joueur ira là.
- `:=` donne une valeur et laisse Godot deviner le type. `etincelles` est un entier.
- L’indentation est obligatoire (une tabulation). Elle remplace les accolades.

## Une fonction que tu appelles toi-même

Ajoute à la fin de `_ready` :

```gdscript
	ajouter_etincelle()
	ajouter_etincelle()
```

Relance. La sortie affiche 1 puis 2. Une fonction est un bloc réutilisable.

## Condition

```gdscript
func ajouter_etincelle() -> void:
	etincelles += 1
	if etincelles >= 3:
		print("Assez d'étincelles.")
	else:
		print("Étincelles : ", etincelles)
```

Relance : deux lignes « Étincelles », pas encore le message final. L’exercice corrige ça.

## Exercice

Dans `_ready`, appelle `ajouter_etincelle()` une troisième fois. Tu dois voir `Assez d'étincelles.`

Ensuite **retire** ces trois appels de `_ready`. Le score montera plus tard quand on ramassera vraiment un objet. Garde la variable et la fonction.

## Bloqué ?

- Erreur « Unexpected indent » : mélange d’espaces et de tabulations. Utilise seulement les tabulations de l’éditeur.
- Rien dans Sortie : tu as lancé une autre scène, ou le script n’est pas sur `Main` (regarde l’icône de parchemin à côté du nœud).
