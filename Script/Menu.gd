extends Control


func _ready():
	pass 




func _on_Play_But_pressed():
	get_tree().change_scene("res://Scene/UI/SelectLevel.tscn")
	pass # Replace with function body.


func _on_Exit_But_pressed():
	get_tree().quit()
	pass # Replace with function body.

func open_map(mappath : String ):
	get_tree().change_scene(mappath)


func _on_Back_button_pressed():
	get_tree().change_scene("res://Scene/UI/Menu.tscn")
	pass # Replace with function body.

func setIMG(imgpath):
	$DownIMG.texture = load(imgpath)
