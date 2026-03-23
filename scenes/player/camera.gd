extends Camera2D

@export var player: CharacterBody2D
@export var dragSensitivity: float = 16.0
@export var dragPlus: Vector2 = Vector2(48.0, 32.0)
@export var dragSpeed: float = 5.0
@export var defZoom: Vector2 = Vector2(4.0, 4.0)
@export var enableSinAnimation: bool = true
@export var sintime: float = 0.0


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
	
	position = position.lerp(targetpos + Vector2(0, -16), clamp(dragSpeed * delta, 0.0, 1.0))
	if enableSinAnimation:
		sintime += delta
		offset = Vector2.ZERO + Vector2(
			sin(sintime) * 3,
			sin(sintime / 2) * 3
		)
