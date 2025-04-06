extends Area2D
class_name StingTrigger

@export var check_string: String
@export var stream: AudioStream
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var has_played: bool = false

func _ready():
	audio.stream = stream

func _on_area_entered(area):
	if area is PlayerInteractionBox and !UiGlobalEventBus.checks.has(check_string):
		audio.play()
		UiGlobalEventBus.checks.append(check_string)
