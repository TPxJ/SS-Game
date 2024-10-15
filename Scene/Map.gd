extends Node2D

var m
onready var mob = $Mob
export var map : String 

func _ready():
	pass 

func _physics_process(delta):
	if mob.get_children().size() == 0: 
		get_tree().change_scene(map)

