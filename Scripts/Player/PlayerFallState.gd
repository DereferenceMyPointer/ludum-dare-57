extends PlayerState
class_name PlayerFallState

@export var move: PlayerState
@export var land_1: AudioStreamPlayer2D
@export var land_2: AudioStreamPlayer2D
var direction: Vector2

func do(p: PlayerCharacter, delta):
	direction = Input.get_vector("Left","Right","Up","Down")
	if p.is_on_floor():
		p.set_state(move)
	p.anim.play("Fall")

func do_physics(p: PlayerCharacter, delta):
	p.move(direction, delta)

func end(p: PlayerCharacter):
	land_1.play()
	land_2.play()
