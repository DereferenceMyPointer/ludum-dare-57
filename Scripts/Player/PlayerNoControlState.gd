extends PlayerState
class_name PlayerNoControlState

@export var animation_string: String
var previous_state: PlayerState

func begin(p: PlayerCharacter):
	p.anim.play(animation_string)
	p.interactor.monitoring = false
	p.interactor.monitorable = false

func end(p: PlayerCharacter):
	p.interactor.monitoring = true
	p.interactor.monitorable = true
