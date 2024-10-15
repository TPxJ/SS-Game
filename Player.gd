extends KinematicBody2D
onready var animsprite = $PPlayer/AnimatedSprite
onready var pplayer = $PPlayer

var SPEED = 300
var GRAVITY = 300
var JUMP_H = 200
var HEALTH = 100

var direc = Vector2()
var veloc = Vector2()

# state var
var is_atck = false

func _ready():
	pass 

func checkfloor() -> bool:
	var r = $CheckFloor
	if r.is_colliding():
		return true
	else:
		return false

func _process(delta):
	gravity_apply(delta)
	movement(delta)
	anim()
	attack()

	pass

func apply_damage(damage):
	HEALTH -= damage

func movement(delta):
	if !is_atck:
		direc = Vector2()
		if Input.is_action_just_pressed("jump") and checkfloor():
			veloc = Vector2.UP * JUMP_H
			
		if Input.is_action_pressed("move_right"):
			direc.x = 1
		elif Input.is_action_pressed("move_left"):
			direc.x = -1
		
		veloc.x = direc.normalized().x * SPEED
		move_and_slide(veloc)
	else: 
		move_and_slide(Vector2(0,veloc.y))
	
func gravity_apply(delta):
	if !checkfloor():
		veloc += Vector2.DOWN * GRAVITY * delta

		
onready var atck_col = $PPlayer/Area2D/Atck_Col
func attack():
	if Input.is_action_just_pressed("attack") and !is_atck:
		animsprite.animation = "attack"
		is_atck = true
		atck_col.disabled = false
		return

func anim():
	if !is_atck:
		if veloc.x == 0:
			animsprite.animation = "idle"
		elif veloc.x != 0:
			animsprite.animation = "run"
		if !checkfloor():
			animsprite.animation = "jump"
		if veloc.x < 0:
			pplayer.scale.x = -1
		if veloc.x > 0:
			pplayer.scale.x = 1


func _on_AnimatedSprite_animation_finished():
	if animsprite.animation == "attack":
		is_atck = false 
		atck_col.disabled = true
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	body.queue_free()
	pass # Replace with function body.
