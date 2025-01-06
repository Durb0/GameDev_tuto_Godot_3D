extends Node3D

var rotation_speed = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		position.y += 10 * delta
		
	if Input.is_action_pressed("ui_left"):
		rotate_z(delta * rotation_speed)
	elif Input.is_action_pressed("ui_right"):
		rotate_z(-delta * rotation_speed)
		
