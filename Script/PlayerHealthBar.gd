extends Node2D

onready var percentext = $CanvasLayer/MarginContainer/Text
onready var textprogress = $CanvasLayer/MarginContainer/TextureProgress
func _process(delta):
	percentext.text = str(textprogress.value)

func set_healthbar(hb : float):
	textprogress.value = hb
