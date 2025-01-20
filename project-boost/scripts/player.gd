extends RigidBody3D
class_name Player

@export_range(700, 2000) var thurst: int = 1000
@export_range(5, 1000) var torque_thrust: int = 200

@onready var explosion_audio: AudioStreamPlayer3D = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer3D = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

var is_transitioning: bool = false
var boosters: Array[Booster] = []

class Booster :
	var name:String
	var active:bool
	var particles: GPUParticles3D
	
	func _init(name:String, particles: GPUParticles3D):
		self.name = name
		self.particles = particles
		self.active = false

func _ready() -> void:
	boosters.append(Booster.new("main", booster_particles))
	boosters.append(Booster.new("right", right_booster_particles))
	boosters.append(Booster.new("left", left_booster_particles))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thurst)
		switch_booster("main", true)
	else:
		switch_booster("main", false)
		
	if Input.is_action_pressed("torque_left"):
		apply_torque(Vector3.MODEL_FRONT * torque_thrust * delta)
		switch_booster("right", true)
	else:
		switch_booster("right", false)
		
	if Input.is_action_pressed("torque_right"):
		apply_torque(Vector3.MODEL_REAR * torque_thrust * delta)
		switch_booster("left", true)
	else:
		switch_booster("left", false)
		
func is_booster_active(booster:Booster):
	return booster.active
	
func get_booster(name: String) -> Booster:
	for booster in boosters:
		if booster.name == name:
			return booster
	return null

func switch_booster(name:String, switch: bool):
	var booster = get_booster(name)
	if switch:
		booster.active = true
		booster.particles.emitting = true
		if(!rocket_audio.playing):
			rocket_audio.play()
	else:
		booster.active = false
		booster.particles.emitting = false
		if !boosters.any(is_booster_active):
			rocket_audio.stop()

func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if body.is_in_group("Goal"):
			land_sequence(body.file_path)
		
		if body.is_in_group("Hazard"):
			crash_sequence()
		
func crash_sequence() -> void:
	lock_controls()
	explosion_audio.play()
	explosion_particles.emitting = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func land_sequence(next_level_file:String) -> void:
	lock_controls()
	success_audio.play()
	success_particles.emitting = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
	
func lock_controls() -> void:
	set_process(false)
	is_transitioning = true
	for booster in boosters:
		switch_booster(booster.name, false)
	
