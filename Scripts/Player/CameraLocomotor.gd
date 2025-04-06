extends CharacterBody2D
class_name CameraLocomotor

@export var target: CharacterBody2D
@export var damp_factor: float = 0.5
@export var aggression: float = 4

func _ready():
	UiGlobalEventBus.snap.connect(snap)

func _physics_process(delta):
	velocity += (target.global_position - global_position) * aggression
	velocity *= damp_factor
	move_and_slide()

func snap(pos: Vector2):
	if pos: global_position = pos
	else: global_position = target.global_position
