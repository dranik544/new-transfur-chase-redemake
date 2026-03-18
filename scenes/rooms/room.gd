extends Node2D
class_name Room

@export var autoDetectEnterAndExit: bool = true
@export var enterpos: Vector2
@export var exitpos: Vector2
@export var autoDetectEnternodeAndExitnode: bool = true
@export var enternode: Node2D
@export var exitnode: Node2D
@export var autoDetectArea: bool = true
@export var area: Area2D


func _ready() -> void:
	if autoDetectEnternodeAndExitnode:
		if enternode == null and get_node("enternode") != null: enternode = get_node("enternode")
		if exitnode == null and get_node("exitnode") != null: exitnode = get_node("exitnode")
	
	if autoDetectEnterAndExit:
		if enternode != null: enterpos = enternode.position
		if exitnode != null: exitpos = exitnode.position
	
	if autoDetectArea:
		if area == null and get_node("area") != null: area = get_node("area")
	
	if area != null:
		area.body_entered.connect(bodyentered)
		area.body_exited.connect(bodyexited)
		if area.get_overlapping_bodies().size() == 0: modulate.a = 0.0
	
	#print(enternode)
	#print(exitnode)
	#print(enterpos)
	#print(exitpos)

func bodyentered(body: CharacterBody2D):
	if area.get_overlapping_bodies().size() > 0:
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate:a", 1.0, 0.5)

func bodyexited(body: CharacterBody2D):
	if area.get_overlapping_bodies().size() == 0:
		var tween: Tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
