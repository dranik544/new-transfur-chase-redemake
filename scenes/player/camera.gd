extends Camera2D

@export var player: Player
@export var dragSensitivity: float = 0.1
@export var dragPlus: Vector2 = Vector2(128.0, 96.0)
@export var dragSpeed: float = 7.0


func _ready() -> void:
	if player == null and get_parent().name == "player": player = get_parent()

func _process(delta: float) -> void:
	if player == null: return
	
	var targetpos: Vector2 = Vector2.ZERO
	if abs(player.velocity.x) > dragSensitivity: targetpos.x = sign(player.velocity.x) * dragPlus.x
	if abs(player.velocity.y) > dragSensitivity: targetpos.y = sign(player.velocity.y) * dragPlus.y
	position = position.lerp(targetpos, clamp(dragSpeed * delta, 0.0, 1.0))
