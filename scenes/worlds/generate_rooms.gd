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
	if alreadyGenerateRooms: generateRandomRooms(20)

func generateRoom(roomScene: PackedScene):
	if roomScene == null or world == null: return
	await get_tree().process_frame
	
	var room: Room = roomScene.instantiate()
	room.global_position = curPosRooms - room.enterpos
	world.add_child(room)
	generatedRooms.append(room)
	curPosRooms = room.position + room.exitpos

func generateRandomRooms(roomCount: int, disableRepeatRooms: bool = true):
	var lastrooms: int
	for i in roomCount:
		var room: int = randi() % genRooms.size()
		if disableRepeatRooms and genRooms.size() > 1:
			while room == lastrooms:
				room = randi() % genRooms.size()
		generateRoom(genRooms[room])
		lastrooms = room
