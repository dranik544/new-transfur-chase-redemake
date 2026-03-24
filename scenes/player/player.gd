extends CharacterBody2D
class_name Player

@export var walkSpeed: float = 220.0
var curSpeed: float = 0.0
@export var velocityChangeWeight: float = 8.0
@export var health: int = 100
@export var latexTimer: Timer
@export var enableLatexInfection: bool = true


func _ready() -> void:
	latexTimer.timeout.connect(latextimertimeout)
	add_to_group("player")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if direction:
		curSpeed = walkSpeed
		velocity = lerp(velocity, direction * curSpeed, velocityChangeWeight * delta)
	else:
		curSpeed = 0.0
		velocity = lerp(velocity, Vector2.ZERO, (velocityChangeWeight * 2.0) * delta)
	
	#velocity = direction * curSpeed
	move_and_slide()

func damage(count: int):
	health -= count
	if health <= 80 and enableLatexInfection: latexTimer.start()

func latextimertimeout():
	if enableLatexInfection: damage(1)
