extends Control
class_name UIManager

@export var anim_speed: float = 0.2
@export var cover: TextureRect

var fading := false
var unfading := false
var fade_elapse := 0.0

func _ready():
	UiGlobalEventBus.fade_to_black.connect(fade_to_black)
	UiGlobalEventBus.unfade.connect(unfade)
	UiGlobalEventBus.unfade.emit()

func fade_to_black():
	fading = true

func unfade():
	unfading = true

func _process(delta):
	if unfading:
		cover.modulate = Color.BLACK
		cover.modulate.a = (anim_speed - fade_elapse) / anim_speed
		fade_elapse += delta
		if fade_elapse >= anim_speed:
			unfading = false
			fading = false
			fade_elapse = 0
			UiGlobalEventBus.fade_over.emit()
	elif fading:
		cover.modulate = Color.BLACK
		cover.modulate.a = fade_elapse / anim_speed
		fade_elapse += delta
		if fade_elapse >= anim_speed:
			fading = false
			unfading = false
			fade_elapse = 0
			UiGlobalEventBus.fade_over.emit()
