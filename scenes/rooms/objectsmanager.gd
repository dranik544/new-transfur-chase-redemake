extends Node

@export var autoDetectObjects: bool = true
@export var objects: Array[Array] = []


func _ready() -> void:
	if autoDetectObjects:
		for child in get_children():
			var objnode = child.get_node_or_null("objects")
			var hitnode = child.get_node_or_null("hitboxes")
			if objnode and hitnode:
				objects.append([objnode, hitnode])
	
	if objects.size() > 0:
		var randomind = randi() % objects.size()
		for i in range(objects.size() - 1, -1, -1):
			if i != randomind:
				objects[i][0].queue_free()
				objects[i][1].queue_free()
				objects.remove_at(i)
		objects[0][0].visible = true
		objects[0][1].visible = true
