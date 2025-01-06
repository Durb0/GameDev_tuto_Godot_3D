extends RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * 1000)
		
	if Input.is_action_pressed("torque_left"):
		apply_torque(Vector3.MODEL_FRONT * 100 * delta)
		
	if Input.is_action_pressed("torque_right"):
		apply_torque(Vector3.MODEL_REAR * 100 * delta)
		
