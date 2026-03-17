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
	if alreadyGenerateRooms:
		for i in 40:
			var r = randi_range(0, 0)
			genRoom(genRooms[r][0], genRooms[r][1])
			print("spawned room num: " + str(i))
		print("completed!")

func genRoom(roomScene: PackedScene, roomType: String):
	if roomScene == null or world == null: return
	await get_tree().process_frame
	
	var room: Room = roomScene.instantiate()
	match roomType:
		"default":
			room.global_position = curPosRooms - room.enterpos
			world.add_child(room)
			generatedRooms.append(room)
			curPosRooms = room.position + room.exitpos
