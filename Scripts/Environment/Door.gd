extends Area2D
class_name Door

@export var door_id: String
@export var target_door: String
@export var target_room_id: String
@export var enter_line: PathFollow2D
@export var animation: String
@export var enter_state: PlayerState
@export var flip: bool = false
@export var requires_interact: bool = false
@export var scene_root: Room
@export var hover_speed = 20
@export var in_arrow: PathFollow2D

func _ready():
	if enter_line.get_child_count() > 0:
		var child = enter_line.get_child(0)
		if child is Character:
			enter(child)

func _process(delta):
	in_arrow.progress += delta * hover_speed

func enter(p: PlayerCharacter):
	enter_line.progress = 0
	p.set_state(enter_state)
	p.graphic.flip_h = flip
	p.reparent(enter_line)
	p.position = Vector2.ZERO
	await get_tree().process_frame
	if scene_root.cam_spawn: UiGlobalEventBus.snap.emit(scene_root.cam_spawn.global_position)
	else: UiGlobalEventBus.snap.emit(null)
	UiGlobalEventBus.unfade.emit()
	await UiGlobalEventBus.fade_over
	var time = Time.get_ticks_usec()
	while enter_line.progress_ratio < 1:
		await get_tree().process_frame
		var new_time = Time.get_ticks_usec()
		var delta = (new_time - time) / 1000000.0
		time = new_time
		enter_line.progress += delta * p.attributes.base_speed
	p.reparent(get_parent())
	set_process(false)
	await get_tree().process_frame
	p.set_state(p.default_state)

func go_in(box: PlayerInteractionBox):
	UiGlobalEventBus.fade_to_black.emit()
	box.master.set_state(enter_state)
	print(2)
	await UiGlobalEventBus.fade_over
	print(name)
	print(target_room_id)
	if target_room_id == '':
		get_tree().quit()
		return
	var new_room = WorldObject.room_database.get_room(target_room_id).instantiate() as Room
	print("entering new room: ", new_room)
	scene_root.add_sibling(new_room)
	var new_door: Door
	for next_door: Door in new_room.doors:
		if next_door.door_id == target_door:
			new_door = next_door
	if new_door:
		new_door.enter(box.master)
		scene_root.queue_free()
	#get_tree().quit() # Load other level, go to door, enter door
		
		### Please remember to change LUL ###

func _on_area_entered(area):
	if !requires_interact and area is PlayerInteractionBox and area.active:
		print(1)
		go_in(area)
	if requires_interact and area is PlayerInteractionBox and area.active:
		in_arrow.visible = true
		set_process(true)
		await area_exited
		in_arrow.visible = false
		set_process(false)
