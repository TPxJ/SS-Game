extends Node


var player : KinematicBody2D


func _input(event):

	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE and is_instance_valid(player):
			get_tree().paused = true
			player.pausescene.turn(true)
			
		if event.pressed and event.scancode == KEY_F11: 
			print("f11")
			OS.window_fullscreen = !OS.window_fullscreen
