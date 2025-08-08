@tool
extends Node3D
class_name Base

@onready var label_3d: Label3D = $Label3D

@export var pv = 10:
	set(value):
		pv = value
		if Engine.is_editor_hint():
			$Label3D.text = str(value)

func _ready() -> void:
	label_3d.text = str(pv)

func takeDamage(damage:int) -> void:
	pv -= damage
	label_3d.text = str(pv)
	print(pv)
