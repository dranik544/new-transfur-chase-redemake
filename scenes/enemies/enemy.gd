extends CharacterBody2D
class_name Enemy

@export var player: Player
@export var speed: float = 120.0
@onready var navagent: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	add_to_group("enemy")
	await get_tree().process_frame
	if player == null and get_tree(): player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null: return
	
	navagent.target_position = player.global_position
	if navagent.is_navigation_finished(): return
	
	var nextpos = navagent.get_next_path_position()
	velocity = global_position.direction_to(nextpos) * speed
	move_and_slide()
