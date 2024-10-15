extends Button

export var imgpath : String
export var scenepath : String
onready var menu  = get_node("../../")

func _on_Button_pressed():
	menu.open_map(scenepath)
	pass # Replace with function body.


func _on_Button_mouse_entered():
	var s = get_tree().get_current_scene()
	s.setIMG(imgpath)
	
	pass # Replace with function body.
