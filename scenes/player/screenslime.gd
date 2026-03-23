extends TextureRect

var tween: Tween

func _ready() -> void:
	animprogress()

func animprogress():
	if tween: tween.kill()
	tween = create_tween()
	tween.set_loops()
	tween.tween_method(progress, 0.0, 1.0, 1.0)

func progress(value: float):
	material.set_shader_parameter("progress", value)
