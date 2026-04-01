extends Node2D

@export var player: CharacterBody2D
@export var areaPickItem: Area2D
@export var spriteItem: Sprite2D
@export var timer: Timer

@export var dragSensitivity: float = 5.0
@export var itemPositionLeft: Vector2
@export var itemPositionRight: Vector2
@export var itemPositionUp: Vector2
@export var itemPositionDown: Vector2

var defaultPosition: Vector2 = Vector2.ZERO
var time: float = 0.0
var currentItem: Item
var itemInArea


func _ready() -> void:
	areaPickItem.body_entered.connect(bodyentered)
	areaPickItem.body_exited.connect(bodyexited)
	timer.timeout.connect(timeout)

func bodyentered(body: Node2D):
	if body.is_in_group("item"):
		itemInArea = body
		timer.start()

func bodyexited(body: Node2D):
	if body.is_in_group("item"):
		itemInArea = null
		timer.stop()

func timeout():
	currentItem = itemInArea
	itemInArea = null
	currentItem.player = player
	currentItem.picked()
	spriteItem.texture = currentItem.sprite.texture

func _process(delta: float) -> void:
	if currentItem == null: return
	
	if Input.is_action_just_pressed("A"):
		currentItem.use()
		currentItem = null
		spriteItem.texture = null
	
	if Engine.get_physics_frames() % 8 != 0: return
	
	if abs(player.velocity.x) > dragSensitivity or abs(player.velocity.y) > dragSensitivity:
		var animname: String
		if abs(player.velocity.x) > abs(player.velocity.y):
			if player.velocity.x > 0:
				defaultPosition = itemPositionRight
				z_index = 0
			else:
				defaultPosition = itemPositionLeft
				z_index = 0
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
