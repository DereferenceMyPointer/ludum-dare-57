extends PlayerState
class_name PlayerNoControlState

@export var animation_string: String
var previous_state: PlayerState

func begin(p: PlayerCharacter):
	p.anim.play(animation_string)
	p.interactor.active = false
	p.collider.disabled = true

func end(p: PlayerCharacter):
	p.interactor.active = true
	p.collider.disabled = false
