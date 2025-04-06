extends PlayerState
class_name PlayerAttackState

@export var hitbox: Hitbox
@export var anim: AnimationPlayer
@export var audio: VariedAudioPlayer
var direction: Vector2

func begin(p: PlayerCharacter):
	p.anim.play("Swipe")
	hitbox.activate()
	hitbox.visible = true
	anim.play("Attack")
	audio.randomize()
	if p.graphic.flip_h: hitbox.scale.x = -1
	else: hitbox.scale.x = 1
	await anim.animation_finished
	p.set_state(p.default_state)

func end(p: PlayerCharacter):
	hitbox.deactivate()
	hitbox.visible = false

func do(p: PlayerCharacter, delta):
	direction = Input.get_vector("Left","Right", "Up", "Down")

func do_physics(p: PlayerCharacter, delta):
	p.move(direction, delta)
