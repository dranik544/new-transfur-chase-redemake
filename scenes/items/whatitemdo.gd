extends Node
class_name whatitemdo

@export var item: Item


func use(type, player: Player):
	match type:
		0:
			if player:
				player.damage(-25)
				deleteitem()

func deleteitem(): if item: item.queue_free()
