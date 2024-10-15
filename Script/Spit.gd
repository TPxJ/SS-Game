extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ppos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	ppos = Game.player.global_position
	yield(get_tree().create_timer(4), "timeout")
	queue_free()
	pass # Replace with function body.




func _physics_process(delta):
	global_position = self.global_position.linear_interpolate(ppos * 2, 0.005)




func _on_Area2D_body_entered(body):
	print(body.get_name())
	if body.has_method("apply_damage"):
		body.apply_damage(10)
		$AnimatedSprite.play("explo")
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "explo":
		queue_free()
	pass # Replace with function body.
