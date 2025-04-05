extends Area2D
class_name Door

@export var door_id: String
@export var target_door: String
@export var target_room: PackedScene
@export var enter_line: PathFollow2D
@export var animation: String
@export var enter_state: PlayerState
@export var scene_root: Node

func _ready():
	if enter_line.get_child_count() > 0:
		var child = enter_line.get_child(0)
		if child is Character:
			enter(child)

func enter(p: PlayerCharacter):
	enter_line.progress = 0
	UiGlobalEventBus.unfade.emit()
	await UiGlobalEventBus.fade_over
	p.set_state(enter_state)
	p.reparent(enter_line)
	var time = Time.get_ticks_usec()
	while enter_line.progress_ratio < 1:
		await get_tree().process_frame
		var new_time = Time.get_ticks_usec()
		var delta = (new_time - time) / 1000000.0
		time = new_time
		enter_line.progress += delta * p.attributes.base_speed
	p.reparent(get_parent())
	set_process(false)
	p.set_state(p.default_state)
	await get_tree().process_frame

func _on_area_entered(area):
	if area is PlayerInteractionBox:
		UiGlobalEventBus.fade_to_black.emit()
		area.master.set_state(enter_state)
		await UiGlobalEventBus.fade_over
		var new_room = target_room.instantiate() as Room
		var new_door: Door
		for next_door: Door in new_room.doors:
			if next_door.door_id == target_door:
				new_door = next_door
		new_door.enter(area.master)
		
		#get_tree().quit() # Load other level, go to door, enter door
		
		### Please remember to change LUL ###
