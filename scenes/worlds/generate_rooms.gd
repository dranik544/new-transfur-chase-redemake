extends Node

# [roomScene: PackedScene, roomType: String]
@export var genRooms: Array = []
@export var autoDetectWorld: bool = true
@export var world: Node2D
@export var alreadyGenerateRooms: bool = false
var generatedRooms = []
var curPosRooms: Vector2 = Vector2.ZERO


func _ready() -> void:
	if autoDetectWorld and world == null: world = get_tree().current_scene
	if alreadyGenerateRooms: pass
	
	print(world)
	
	for i in 50:
		var r = randi_range(1, 2)
		match r:
			1: genRoom(genRooms[0][0], genRooms[0][1])
			2: genRoom(genRooms[1][0], genRooms[1][1])

func genRoom(roomScene: PackedScene, roomType: String):
	if roomScene == null or world == null: return
	await get_tree().process_frame
	print("spawn")
	
	var room: Room = roomScene.instantiate()
	match roomType:
		"default":
			room.global_position = curPosRooms - room.enterpos
			world.add_child(room)
			generatedRooms.append(room)
			curPosRooms = room.position + room.exitpos
