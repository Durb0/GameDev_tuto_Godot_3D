extends RigidBody3D
class_name Player

@export_range(700, 2000) var thurst: int = 1000
@export_range(5, 1000) var torque_thrust: int = 200

@onready var explosion_audio: AudioStreamPlayer3D = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer3D = $SuccessAudio

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thurst)
		
	if Input.is_action_pressed("torque_left"):
		apply_torque(Vector3.MODEL_FRONT * torque_thrust * delta)
		
	if Input.is_action_pressed("torque_right"):
		apply_torque(Vector3.MODEL_REAR * torque_thrust * delta)
		


func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if body.is_in_group("Goal"):
			land_sequence(body.file_path)
		
		if body.is_in_group("Hazard"):
			crash_sequence()
		
func crash_sequence() -> void:
	lock_controls()
	explosion_audio.play()
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func land_sequence(next_level_file:String) -> void:
	lock_controls()
	success_audio.play()
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
	
func lock_controls() -> void:
	set_process(false)
	is_transitioning = true
	
