extends CharacterBody2D
class_name Player

@export var walkSpeed: float = 350.0
var curSpeed: float = 0.0
@export var velocityChangeWeight: float = 8.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		curSpeed = walkSpeed
		velocity = lerp(velocity, direction * curSpeed, velocityChangeWeight * delta)
	else:
		curSpeed = 0.0
		velocity = lerp(velocity, Vector2.ZERO, (velocityChangeWeight * 2.0) * delta)
	
	#velocity = direction * curSpeed
	move_and_slide()
