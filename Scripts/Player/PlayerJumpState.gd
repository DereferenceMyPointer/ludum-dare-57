extends PlayerState
class_name PlayerJumpState

@export var move: PlayerState
@export var fall: PlayerState
@export var speed_graph: CurveTexture
var direction: Vector2
var was_on_floor: bool
var starting_y: float

func begin(p: PlayerCharacter):
	# Jump up animation
	was_on_floor = p.is_on_floor()
	starting_y = p.position.y
	p.anim.play("Jump")
	pass

func do(p: PlayerCharacter, delta):
	direction = Input.get_vector("Left","Right", "Up", "Down")
	p.anim.play("Fly")
	if !Input.is_action_pressed("Jump") or starting_y - p.position.y > p.attributes.base_jump_height or p.is_on_ceiling():
		# Change to fall state
		p.set_state(fall)
	#if p.is_on_floor() and !was_on_floor:
	#	p.set_state(move)
	was_on_floor = p.is_on_floor()

func do_physics(p: PlayerCharacter, delta):
	var progress_quotient: float = abs(starting_y - p.position.y) / p.attributes.base_jump_height
	p.velocity.y = -p.attributes.base_jump_speed * speed_graph.curve.sample(progress_quotient)
	p.move(direction, delta)
