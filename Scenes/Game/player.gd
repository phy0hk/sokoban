extends CharacterBody2D


@export var SPEED = 300.0
@export var TILE_SIZE = 132
var input_dir = Vector2.ZERO
var moving = false

func _physics_process(delta: float) -> void:
	get_input()
	

func get_input():
	if Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2(0,-1)
		move()
	elif Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2(0,1)
		move()
	elif Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2(-1,0)
		move()
	elif Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2(1,0)
		move()
	else:
		input_dir = Vector2.ZERO

func move():
	if input_dir:
		if !moving:
			moving = true
			var tween =  create_tween()
			tween.tween_property(self,"position",position+input_dir*TILE_SIZE,0.2)
			tween.tween_callback(stop_move)

func stop_move():
	moving = false
