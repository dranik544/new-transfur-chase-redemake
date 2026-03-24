extends Area2D

@export var player: CharacterBody2D
@export var attackTimer: Timer
var enemiesInArea: Array = []


func _ready() -> void:
	if player == null and get_parent().name == "player": player = get_parent()
	
	body_entered.connect(bodyentered)
	body_exited.connect(bodyexited)
	attackTimer.timeout.connect(attacktimertimeout)

func bodyentered(body: CharacterBody2D):
	if body.is_in_group("enemy") and body.damage != null:
		enemiesInArea.append(body)
		if attackTimer.is_stopped(): attackTimer.start(0.5)

func bodyexited(body: CharacterBody2D):
	if body in enemiesInArea:
		enemiesInArea.erase(body)
		if enemiesInArea.size() <= 0: attackTimer.stop()

func attacktimertimeout():
	if enemiesInArea.size() <= 0: return
	if player.has_method("damage"): player.damage(enemiesInArea.get(0).damage)
	attackTimer.start(0.5)
