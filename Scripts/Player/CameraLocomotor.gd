extends CharacterBody2D
class_name CameraLocomotor

@export var target: CharacterBody2D
@export var damp_factor: float = 0.5
@export var aggression: float = 4

func _physics_process(delta):
	velocity += (target.position - position) * aggression
	velocity *= damp_factor
	move_and_slide()
