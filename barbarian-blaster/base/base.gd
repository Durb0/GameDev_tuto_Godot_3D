extends Node3D
class_name Base

@onready var label_3d: Label3D = $Label3D

@export var max_pv: int = 10:
	set(value):
		max_pv = value
		if Engine.is_editor_hint():
			$Label3D.text = str(value)
			
var pv: int:
	set(value):
		pv = value
		if Engine.is_embedded_in_editor():
			$Label3D.text = str(value)
		if pv < 1:
			get_tree().reload_current_scene()

func _ready() -> void:
	pv = max_pv

func takeDamage(damage:int) -> void:
	pv -= damage
