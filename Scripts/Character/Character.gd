extends CharacterBody2D
class_name Character

@export var attributes: CharacterStats
@export var anim: AnimationPlayer
@export var graphic: Sprite2D

func move(direction: Vector2, delta):
	velocity.x = sign(direction.x) * attributes.base_speed
	if !is_equal_approx(velocity.x, 0): graphic.flip_h = velocity.x < 0
	velocity.y += attributes.base_gravity_scale * delta
	if !is_on_floor():
		velocity.y = min(velocity.y, attributes.base_fall_cap)
	move_and_slide()
