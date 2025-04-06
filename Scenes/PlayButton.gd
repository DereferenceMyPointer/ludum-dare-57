extends TextureButton

@export var starting_scene: PackedScene
@export var root: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(play)


func play():
	root.add_sibling(starting_scene.instantiate())
	root.queue_free()
