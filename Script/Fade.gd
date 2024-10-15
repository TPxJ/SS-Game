extends CanvasLayer

export var PlayOnStart : bool = false
export var Speed : float = 1
export var reverse : bool = false
onready var Animate = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayOnStart:
		Animate.play("Fade",-1, Speed, reverse)
	pass 


