extends CharacterBody2D


@export var SPEED = 300.0
@export var TILE_SIZE = 32
@onready var ray = $RayCast2D
var input_dir = Vector2.ZERO
var moving = false
var prev_pos 

func _physics_process(delta: float) -> void:
	get_input()

func get_input():
	if Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2.UP
		attempt_move()
	elif Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2.DOWN
		attempt_move()
	elif Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2.LEFT
		attempt_move()
	elif Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		attempt_move()
	else:
		input_dir = Vector2.ZERO

func attempt_move():
	if input_dir:
		if !moving:
			ray.target_position = input_dir * TILE_SIZE
			ray.force_raycast_update()
			if !ray.is_colliding():
				move()
			else:
				var collider = ray.get_collider()
				print(collider.is_in_group("box"))
				if collider.is_in_group("box"):
					if collider.request_move(input_dir):
						move()

func move():
	moving = true
	prev_pos = self.position
	var tween =  create_tween()
	tween.tween_property(self,"position",position+input_dir*TILE_SIZE,0.2)
	tween.tween_callback(stop_move)


func stop_move():
	moving = false
