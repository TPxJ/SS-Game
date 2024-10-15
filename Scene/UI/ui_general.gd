extends Node2D

func _ready():
	$AnimationPlayer.play("to_menu", -1, 0.5)

func _scene_change(scene):
	get_tree().change_scene(scene)


func _on_Resume_But_pressed():
	get_tree().paused = false
	pass # Replace with function body.


func _on_QuitToMenu_But_pressed():
	_scene_change("res://Scene/UI/Menu.tscn")
	pass # Replace with function body.
