extends Area2D

@export var player: CharacterBody2D


func _ready() -> void:
	if player == null and get_parent().name == "player": player = get_parent()
	
	body_entered.connect(bodyentered)
	body_exited.connect(bodyexited)

func bodyentered(body: CharacterBody2D):
	if body.is_in_group("enemy") and body.damage != null:
		if player.has_method("damage"): player.damage(body.damage)

func bodyexited(body: CharacterBody2D):
	pass
