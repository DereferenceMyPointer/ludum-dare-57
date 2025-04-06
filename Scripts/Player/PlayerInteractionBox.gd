extends Area2D
class_name PlayerInteractionBox

@export var master: PlayerCharacter
@export var active: bool = true

func interact():
	for area in get_overlapping_areas():
		if area is Door: ## CHANGE TO INTERACTABLE
			area.go_in(self)
