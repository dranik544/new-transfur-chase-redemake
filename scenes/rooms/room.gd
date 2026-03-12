extends Node2D

@export var autoDetectEnterAndExit: bool = true
@export var enterpos: Vector2
@export var exitpos: Vector2
@export var autoDetectEnternodeAndExitnode: bool = true
@export var enternode: Node2D
@export var exitnode: Node2D


func _ready() -> void:
	if autoDetectEnternodeAndExitnode:
		if enternode == null and get_node("enternode") != null: enternode = get_node("enternode")
		if exitnode == null and get_node("exitnode") != null: exitnode = get_node("exitnode")
	
	if autoDetectEnterAndExit:
		if enternode != null: enterpos = enternode.position
		if exitnode != null: exitpos = exitnode.position
	
	#print(enternode)
	#print(exitnode)
	#print(enterpos)
	#print(exitpos)
