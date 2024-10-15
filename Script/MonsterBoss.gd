extends KinematicBody2D


export var attack_frame : int = 0
onready var rfloor = $CheckFloor
onready var scol = $Collision
onready var pplayer = $PPlayer
onready var animsprite = $PPlayer/AnimatedSprite
onready var healthbar = $HealthBar

var random = RandomNumberGenerator.new()

var p

var move = Vector2()
var veloc = Vector2()

export var DAMAGE  = 10
export var MAX_HEALTH = 100
export var HEALTH = 100
export var SPEED = 100
export var GRAVITY = 300

var is_takehit = false
var is_atck = false
var can_atck = true
var is_death = false

var rmon


func _ready():
	p = Game.player
	random.randomize()
	rmon = random.randi_range(25, 80)
	healthbar.set_maxhealthbar(MAX_HEALTH)
	pass 

func _physics_process(delta):
	if !is_death:
		gravity_apply(delta)
		movement(delta)
		anim()
		healthbar.set_healthbar(HEALTH)
	else:
		animsprite.animation = "death"
		disable_ondeath()
	pass

func apply_damage(damage):
	take_hit(damage)
	
func take_hit(damage):
	if !can_atck and !is_death and !is_atck:
		is_takehit =true
		animsprite.animation = "takehit"
		HEALTH -= damage
#	elif !is_death and !is_takehit:
#		is_atck = false
#		is_takehit =true
#		animsprite.animation = "takehit"
#		HEALTH -= damage
#		get_tree().create_timer(2.0).connect("timeout", self, "set_canatck")
		
func checkfloor() -> bool:
	if rfloor.is_colliding():
		return true
	else:
		return false

func gravity_apply(delta):
	if !is_on_floor():
		veloc += Vector2.DOWN * 300 * delta

func movement(delta):
	if self.global_position.distance_to(p.global_position) > rmon:
		move = self.global_position.direction_to(p.global_position) 
		move = move.normalized()
		veloc.x = move.x * SPEED
	else:
		veloc.x = 0
		if !is_atck and can_atck:
			attack()
	
	move_and_slide(veloc, Vector2.UP, true)

onready var atck_col = $PPlayer/Area2D/Atck_Col
func attack():
	if !is_atck and can_atck and !is_takehit:
		is_atck = true
		animsprite.animation = "attack"
		can_atck = false
		
func anim():
	if !is_takehit and !is_atck:
		if veloc.x == 0:
			animsprite.animation = "idle"
		elif veloc.x != 0:
			animsprite.animation = "run"
		if veloc.x < 0:
			pplayer.scale.x = -1
		if veloc.x > 0:
			pplayer.scale.x = 1
	elif HEALTH <= 0: 
		is_death = true

func _on_AnimatedSprite_animation_finished():
	if animsprite.animation == "takehit":
		is_takehit = false
	if animsprite.animation == "death":
		yield(get_tree().create_timer(2.0), "timeout")
		queue_free()
	if animsprite.animation == "attack":
		is_atck = false
		atck_col.disabled = true
		get_tree().create_timer(2.0).connect("timeout", self, "set_canatck")
	pass
	
func _on_Area2D_body_entered(body):
	make_damage(body)
	pass

func make_damage(body):
	if body.has_method("apply_damage"):
		body.apply_damage(DAMAGE)

func set_canatck():
	can_atck = true
	pass


func _on_AnimatedSprite_frame_changed():
	if animsprite.animation == "attack" and animsprite.frame == attack_frame:
		atck_col.disabled = false
	pass # Replace with function body.

func disable_ondeath():
	atck_col.disabled = true
	scol.disabled = true
	rfloor.enabled = false
	
