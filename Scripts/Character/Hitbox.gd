extends Area2D
class_name Hitbox

@export var master: Character
@export var base_damage: float
@onready var collider: CollisionShape2D = $CollisionShape2D

func hit(target: Character):
	pass

func activate():
	collider.disabled = false

func deactivate():
	collider.disabled = true
