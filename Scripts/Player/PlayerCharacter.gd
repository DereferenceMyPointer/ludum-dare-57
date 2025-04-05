extends Character
class_name PlayerCharacter

@export var state: PlayerState
@export var default_state: PlayerState
@export var interactor: PlayerInteractionBox

func _process(delta):
	state.do(self, delta)

func _physics_process(delta):
	state.do_physics(self, delta)

func set_state(other: PlayerState):
	state.end(self)
	state = other
	state.begin(self)
