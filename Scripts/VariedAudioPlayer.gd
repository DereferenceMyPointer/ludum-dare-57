extends AudioStreamPlayer2D
class_name VariedAudioPlayer

@export var max_variation: float

func randomize():
	pitch_scale = 1 + randf_range(-max_variation, max_variation)
	play()
