extends Control

var pv_elora := 30
var pv_garde := 24
var garde := false
var tour_joueur := true
var fini := false

@onready var journal: Label = $Journal
@onready var pv: Label = $PV
@onready var bouton_intention: Button = $Actions/Intention

func _ready() -> void:
	$Actions/Attaquer.pressed.connect(_attaquer)
	bouton_intention.pressed.connect(_intention)
	$Actions/Garde.pressed.connect(_defendre)
	if GameState.a_une_sparkle():
		bouton_intention.text = "2  " + GameState.sparkle_intention
	else:
		bouton_intention.text = "2  Intention"
		bouton_intention.disabled = true
	_dire("Un garde bloque le passage.")
	_rafraichir()

func _attaquer() -> void:
	if not _peut_jouer():
		return
	var degats := 7 + randi() % 4
	pv_garde = max(0, pv_garde - degats)
	_dire("Elora attaque : %d." % degats)
	_suite()

func _intention() -> void:
	if not _peut_jouer() or not GameState.a_une_sparkle():
		return
	var degats := 7 + GameState.bonus + randi() % 4
	pv_garde = max(0, pv_garde - degats)
	_dire("Intention %s : %d." % [GameState.sparkle_intention, degats])
	_suite()

func _defendre() -> void:
	if not _peut_jouer():
		return
	garde = true
	_dire("Elora se couvre.")
	_suite()

func _peut_jouer() -> bool:
	return tour_joueur and not fini

func _suite() -> void:
	tour_joueur = false
	_rafraichir()
	if pv_garde <= 0:
		_finir(true)
		return
	await get_tree().create_timer(0.5).timeout
	var degats := 6 + randi() % 3
	if garde:
		degats = int(degats / 2.0)
		garde = false
	pv_elora = max(0, pv_elora - degats)
	_dire("Le garde riposte : %d." % degats)
	if pv_elora <= 0:
		_finir(false)
		return
	tour_joueur = true
	_rafraichir()

func _finir(victoire: bool) -> void:
	fini = true
	tour_joueur = false
	if victoire:
		_dire("Le passage est libre. [E] pour revenir.")
	else:
		_dire("Elora tombe. [E] pour revenir.")
	_rafraichir()

func _dire(ligne: String) -> void:
	journal.text = ligne

func _rafraichir() -> void:
	pv.text = "Elora %d    Garde %d" % [pv_elora, pv_garde]
	var bloque := fini or not tour_joueur
	$Actions/Attaquer.disabled = bloque
	$Actions/Garde.disabled = bloque
	bouton_intention.disabled = bloque or not GameState.a_une_sparkle()

func _unhandled_input(event: InputEvent) -> void:
	if fini and event.is_action_pressed("interact"):
		GameState.vers_monde()
