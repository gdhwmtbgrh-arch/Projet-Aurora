extends Resource
class_name Sparkle

## Une "sparkle" équipable (inspiration djinn, pas une copie Golden Sun).
## Elle porte une *intention* qui modifie l'action en combat (stub de la boucle
## explorer -> sparkles -> équiper -> intentions -> combos d'équipe).

enum Intention { COURAGE, CONNAISSANCE, PARTAGE, INSTINCT }

@export var nom: String = "Sparkle"
@export var totem: String = "Ours"
@export var intention: Intention = Intention.COURAGE
@export var bonus_degats: int = 6
@export var couleur: Color = Color("#ffd36e")

func intention_nom() -> String:
	match intention:
		Intention.COURAGE: return "Courage"
		Intention.CONNAISSANCE: return "Connaissance"
		Intention.PARTAGE: return "Partage"
		Intention.INSTINCT: return "Instinct"
	return "?"

func describe() -> String:
	return "%s (%s) +%d dgt" % [nom, intention_nom(), bonus_degats]
