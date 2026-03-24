extends TextureRect

var tween: Tween
@export var updateByHealth: bool = true
@export var player: CharacterBody2D

func _ready() -> void:
	texture.fill_from.y = 0.0
	animprogress()

func _process(delta: float) -> void:
	if updateByHealth or player != null: texture.fill_from.y = lerp(texture.fill_from.y, abs(1.0 - float(player.health) / 100), 0.5 * delta)

func animprogress():
	if tween: tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_method(progress, 0.0, 1.0, 6.5)
	tween.tween_method(progress, 1.0, 0.0, 6.5)
	tween.set_loops()
func progress(value: float):
	material.set_shader_parameter("progress", value);
	material.set_shader_parameter("how_low", 1.0 + value)
