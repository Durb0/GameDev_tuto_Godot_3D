extends RigidBody3D
class_name Player

signal landed
signal crashed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * 1000)
		
	if Input.is_action_pressed("torque_left"):
		apply_torque(Vector3.MODEL_FRONT * 100 * delta)
		
	if Input.is_action_pressed("torque_right"):
		apply_torque(Vector3.MODEL_REAR * 100 * delta)
		


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Goal"):
		print("gg")
		landed.emit()
	elif body.is_in_group("Hazard"):
		print("boom")
		crashed.emit()
