extends Node2D

onready var percentext = $Control/TextureProgress/Percent
onready var textprogress = $Control/TextureProgress
func _process(delta):
	percentext.text = str(textprogress.value)

func set_healthbar(hb : float):
	textprogress.value = hb

func set_maxhealthbar(hb : float):
	textprogress.max_value = hb
