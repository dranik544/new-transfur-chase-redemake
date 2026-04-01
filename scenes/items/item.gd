extends StaticBody2D
class_name Item

enum type {healPlayer}
@export var itemType: type
@export var sprite: Sprite2D
@export var whatitemdo: whatitemdo
@export var player: Player


func _ready() -> void:
	add_to_group("item")

func use():
	if whatitemdo != null: whatitemdo.use(itemType, player)

func picked():
	hide()
	global_position = Vector2(-9999, -9999)
