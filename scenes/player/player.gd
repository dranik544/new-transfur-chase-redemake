extends CharacterBody2D
class_name Player

@export var walkSpeed: float = 220.0
@export var dashSpeed: float = 490.0
@export var velocityChangeWeight: float = 8.0
@export var health: int = 100
@export var latexTimer: Timer
@export var enableLatexInfection: bool = true
@export var dashDuration: float = 0.6
@export var dashCooldown: float = 2.5

var curSpeed: float = 0.0
var nowDash: bool = false
var canDash: bool = true
var timerDash: float = 0.0


func _ready() -> void:
	latexTimer.timeout.connect(latextimertimeout)
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("V") and !nowDash and canDash:
		nowDash = true
		canDash = false
		timerDash = dashDuration
		set_collision_mask_value(5, false)
	
	if nowDash:
		timerDash -= delta
		if timerDash <= 0.0:
			print("now dont dash")
			nowDash = false
			set_collision_mask_value(5, true)
			var cooldowntimer: Timer = Timer.new()
			cooldowntimer.wait_time = dashCooldown
			cooldowntimer.one_shot = true
			cooldowntimer.timeout.connect(
				func():
					cooldowntimer.queue_free()
					canDash = true
			)
			add_child(cooldowntimer)
			cooldowntimer.start()
	
	var additionalDashSpeed: float = (dashSpeed * 0.005) if nowDash else 1.0
	
	var direction := Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if direction:
		curSpeed = walkSpeed
		velocity = lerp(velocity, direction * curSpeed * additionalDashSpeed, velocityChangeWeight * delta)
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
