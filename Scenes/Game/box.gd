extends Area2D

var is_moving = false
@export var TILE_SIZE = 32
@onready var ray = $RayCast2D

func request_move(dir:Vector2):
	print(dir)
	ray.target_position = dir*TILE_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		move(dir)
		return true
	return false

func move(dir:Vector2):
	if !is_moving:
		var tween = create_tween()
		tween.tween_property(self,"position",position+dir*TILE_SIZE,0.18)
		tween.tween_callback(stop_move)


func stop_move():
	is_moving = false
