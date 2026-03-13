extends Area2D

var is_moving = false
var direction = Vector2.ZERO
@export var TILE_SIZE = 132

func _physics_process(delta: float) -> void:
	detect_direction()


func _on_body_entered(body: Node2D) -> void:
	#is_body_entered = true
	move()

func detect_direction():
	if $Right.is_colliding():
		if $Right.get_collider().name == "Player":
			direction = Vector2(-1,0)
	elif $Left.is_colliding():
		if $Left.get_collider().name == "Player":
			direction = Vector2(1,0)
	elif $Up.is_colliding():
		if $Up.get_collider().name == "Player":
			direction = Vector2(0,1)
	elif $Down.is_colliding():
		if $Down.get_collider().name == "Player":
			direction = Vector2(0,-1)
	else:
		direction = Vector2.ZERO


func move():
	if !is_moving:
		var tween = create_tween()
		tween.tween_property(self,"position",position+direction*TILE_SIZE,0.18)
		tween.tween_callback(stop_move)


func stop_move():
	is_moving = false
