extends GPUParticles2D

@export var player: CharacterBody2D


func _process(delta: float) -> void:
	if Engine.get_physics_frames() % 80 == 0 and player != null:
		if player.health >= 100: emitting = false; return
		
		emitting = true
		amount_ratio = 1.0 - player.health / 100
