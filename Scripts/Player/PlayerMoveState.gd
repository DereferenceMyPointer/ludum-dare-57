extends PlayerState
class_name PlayerMoveState

@export var jump: PlayerState
@export var fall: PlayerState
@export var step_1: VariedAudioPlayer
@export var step_2: VariedAudioPlayer
@export var step_rate: float
var direction: Vector2
var footstep_cooldown: float = 1.0
var footstep_state: bool = false

func begin(p: PlayerCharacter):
	p.anim.play("Idle")
	pass

func do(p: PlayerCharacter, delta):
	direction = Input.get_vector("Left","Right", "Up", "Down")
	if footstep_cooldown > 0:
		footstep_cooldown -= delta
	# Manage animation
	if Input.is_action_just_pressed("Jump"): p.set_state(jump)
	if !p.is_on_floor(): p.set_state(fall)

func do_physics(p: PlayerCharacter, delta):
	p.move(direction, delta)
	if is_equal_approx(0, p.velocity.x):
		p.anim.play("Idle")
	else:
		p.anim.play("Run")
		if footstep_cooldown <= 0:
			if footstep_state:
				step_1.randomize()
			else:
				step_2.randomize()
			footstep_cooldown = step_rate
			footstep_state = !footstep_state
