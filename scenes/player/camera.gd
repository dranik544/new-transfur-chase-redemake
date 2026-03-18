extends Camera2D

@export var player: Player
@export var dragSensitivity: float = 35.0
@export var dragPlus: Vector2 = Vector2(64.0, 48.0)
@export var dragSpeed: float = 5.5
@export var defZoom: Vector2 = Vector2(2.0, 2.0)


func _ready() -> void:
	if player == null and get_parent().name == "player": player = get_parent()

func _process(delta: float) -> void:
	if player == null: return
	
	var targetpos: Vector2 = Vector2.ZERO
	if abs(player.velocity.x) > dragSensitivity or abs(player.velocity.y) > dragSensitivity:
		zoom = lerp(zoom, defZoom / 1.25, dragSpeed * delta)
		if abs(player.velocity.x) > dragSensitivity: targetpos.x = sign(player.velocity.x) * dragPlus.x
		if abs(player.velocity.y) > dragSensitivity: targetpos.y = sign(player.velocity.y) * dragPlus.y
	else: zoom = lerp(zoom, defZoom, dragSpeed * delta)
	
	position = position.lerp(targetpos, clamp(dragSpeed * delta, 0.0, 1.0))
