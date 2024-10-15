extends Monster_Base



func _ready(): 
	pass 

func _physics_process(delta):
	pass
func _on_Timer_timeout():
	if !spit:
		animsprite.animation = "spit"
		spit = true
	pass
