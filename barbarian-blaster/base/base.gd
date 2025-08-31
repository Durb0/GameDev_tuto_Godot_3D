@tool
extends Node3D
class_name Base

@onready var label_3d: Label3D  = $Label3D

@export var max_pv: int = 10:
	set(value):
		max_pv = value
		if Engine.is_editor_hint():
			pv = value
		showLabelText()
			
var pv: int:
	set(value):
		pv = value
		showLabelText()
		label_3d.modulate = Color.RED.lerp(
			Color.WHITE,
			float(pv) / float(max_pv)
		)
		if pv < 1:
			get_tree().reload_current_scene()

func _ready() -> void:
	pv = max_pv

func takeDamage(damage:int) -> void:
	pv -= damage
	
func showLabelText():
	label_3d.text = str(pv) + "/" + str(max_pv)
