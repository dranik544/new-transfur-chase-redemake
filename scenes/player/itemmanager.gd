extends Node2D

@export var player: CharacterBody2D
@export var areaPickItem: Area2D
@export var spriteItem: Sprite2D

@export var dragSensitivity: float = 5.0
@export var itemPositionLeft: Vector2
@export var itemPositionRight: Vector2
@export var itemPositionUp: Vector2
@export var itemPositionDown: Vector2

var defaultPosition: Vector2 = Vector2.ZERO
var time: float = 0.0


func _ready() -> void:
	areaPickItem.body_entered.connect(bodyentered)
	areaPickItem.body_exited.connect(bodyexited)

func bodyentered(body: Node2D):
	pass

func bodyexited(body: Node2D):
	pass

func _process(delta: float) -> void:
	if Engine.get_physics_frames() % 4 != 0: return
	
	if abs(player.velocity.x) > dragSensitivity or abs(player.velocity.y) > dragSensitivity:
		var animname: String
		if abs(player.velocity.x) > abs(player.velocity.y):
			if player.velocity.x > 0:
				defaultPosition = itemPositionRight
				z_index = 0
			else:
				defaultPosition = itemPositionLeft
				z_index = -1
		else:
			if player.velocity.y > 0:
				defaultPosition = itemPositionDown
				z_index = 0
			else:
				defaultPosition = itemPositionUp
				z_index = -1
		
		time += delta
		position = defaultPosition + Vector2(
			0.0,
			sin(time * 16.0) * 4.0
		)
