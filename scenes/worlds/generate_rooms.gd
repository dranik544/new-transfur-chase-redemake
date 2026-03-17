extends Node

# roomScene: PackedScene
@export var genRooms: Array = []
@export var autoDetectWorld: bool = true
@export var world: Node2D
@export var alreadyGenerateRooms: bool = false
var generatedRooms = []
var curPosRooms: Vector2 = Vector2.ZERO


func _ready() -> void:
	if autoDetectWorld and world == null: world = get_tree().current_scene
	if alreadyGenerateRooms:
		for i in 35:
			var r = randi_range(0, genRooms.size() - 1)
			genRoom(genRooms[r])
			print("spawned room num: " + str(i))
		print("completed!")

func genRoom(roomScene: PackedScene):
	if roomScene == null or world == null: return
	await get_tree().process_frame
	
	var room: Room = roomScene.instantiate()
	room.global_position = curPosRooms - room.enterpos
	world.add_child(room)
	generatedRooms.append(room)
	curPosRooms = room.position + room.exitpos
