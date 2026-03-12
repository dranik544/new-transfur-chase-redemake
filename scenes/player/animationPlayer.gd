extends AnimatedSprite2D

@export var player: Player
@export var dragSensitivity: float = 5.0


func _ready() -> void:
	if player == null and get_parent().name == "player": player = get_parent()
	frame = 1

func _process(delta: float) -> void:
	if player == null: return
	if abs(player.velocity.x) <= dragSensitivity and abs(player.velocity.y) <= dragSensitivity:
		if is_playing(): stop(); frame = 1
		return
	
	if abs(player.velocity.x) > dragSensitivity or abs(player.velocity.y) > dragSensitivity:
		var animname: String
		if abs(player.velocity.x) > abs(player.velocity.y):
			if player.velocity.x > 0: animname = "right"
			else: animname = "left"
		else:
			if player.velocity.y > 0: animname = "down"
			else: animname = "up"
		
		play(animname)
		speed_scale = (abs(player.velocity.x) + abs(player.velocity.y)) * 0.005
		
