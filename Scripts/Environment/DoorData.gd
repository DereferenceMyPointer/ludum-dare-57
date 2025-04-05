extends Resource
class_name DoorData

# Format: room_name_identifier
@export var id: String
# Door id
@export var to_door: ID
@export var to_room: ID

enum ID {
	Room_1_W
}
