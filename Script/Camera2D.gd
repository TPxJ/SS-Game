extends Camera2D

export var player : NodePath
export var limit_min : float
export var limit_max : float
export var limit_minY : float
export var limit_maxY : float
export var useY : bool = false
var p
var ppos
# Called when the node enters the scene tree for the first time.
func _ready():
	p = Game.player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ppos = Vector2(p.global_position.x, p.global_position.y - 50)
	global_position = lerp(global_position , ppos , 0.1)
	global_position.x = clamp(global_position.x ,limit_min ,limit_max)
	if useY:
		global_position.y = clamp(global_position.y, limit_minY, limit_maxY)
	pass
