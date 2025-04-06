extends Resource
class_name RoomDatabase

@export var rooms: Array[RoomData]

func get_room(id: String) -> PackedScene:
	print("Getting " + id)
	for room in rooms:
		if room.id == id: return room.scene
	return null
