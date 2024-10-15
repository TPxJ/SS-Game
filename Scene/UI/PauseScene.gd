extends Control



func _scene_change(scene):
	get_tree().change_scene(scene)


func _on_Resume_But_pressed():
	get_tree().paused = false
	turn(false)
	pass # Replace with function body.


func _on_QuitToMenu_But_pressed():
	_scene_change("res://Scene/UI/Menu.tscn")
	get_tree().paused = false
	pass # Replace with function body.

func turn(t: bool):
	match t:
		true:
			visible = true
			mouse_filter = Control.MOUSE_FILTER_STOP
		false:
			visible = false
			mouse_filter = Control.MOUSE_FILTER_IGNORE
		
