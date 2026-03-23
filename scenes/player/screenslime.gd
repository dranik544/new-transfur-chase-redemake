extends TextureRect

var tween: Tween
@export var updateByHealth: bool = true
@export var player: CharacterBody2D

func _ready() -> void:
	texture.fill_from.y = 0.0
	animprogress()

func _process(delta: float) -> void:
	if updateByHealth or player != null: texture.fill_from.y = lerp(texture.fill_from.y, abs(1.0 - float(player.health) / 100), 1 * delta)

func animprogress():
	if tween: tween.kill()
	tween = create_tween()
	tween.set_loops()
	tween.tween_method(progress, 0.0, 1.0, 6.0)
func progress(value: float): material.set_shader_parameter("progress", value)
