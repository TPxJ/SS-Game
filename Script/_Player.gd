extends KinematicBody2D
onready var animsprite = $PPlayer/AnimatedSprite
onready var pplayer = $PPlayer
onready var healthbar = $PlayerHealthBar
onready var pausescene = $CanvasLayer/PauseScene

var random = RandomNumberGenerator.new()

var SPEED = 300
var GRAVITY = 300
var JUMP_H = 200
var HEALTH = 100

var direc = Vector2()
var veloc = Vector2()

# state var
var is_atck = false
var is_die = false

func _ready():
	Game.player = self
	pass 

func checkfloor() -> bool:
	var r = $CheckFloor
	if r.is_colliding():
		return true
	else:
		return false

func _physics_process(delta):
	gravity_apply(delta)
	movement(delta)
	anim()
	attack()
	healthbar.set_healthbar(HEALTH)
	if HEALTH <= 0:
		die()
	pass

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
		move_and_slide(veloc , Vector2.UP , true)
	else: 
		move_and_slide(Vector2(0,veloc.y), Vector2.UP, true)
	
func gravity_apply(delta):
	
	if !is_on_floor():
		veloc += Vector2.DOWN * GRAVITY * delta

		
onready var atck_col = $PPlayer/Area2D/Atck_Col
func attack():
	if Input.is_action_just_pressed("attack") and !is_atck:
		animsprite.animation = "attack"
		is_atck = true
		atck_col.disabled = false
		return


func apply_damage(damage):
	HEALTH -= damage

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
	random.randomize()
	if body.has_method("apply_damage"):
		body.apply_damage(random.randi_range(25,40))
	pass

func die():
	is_die = true
	get_tree().change_scene("res://Scene/UI/GameOver.tscn")
