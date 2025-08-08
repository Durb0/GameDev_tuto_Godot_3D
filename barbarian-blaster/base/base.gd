extends Node3D
class_name Base

@export var pv = 10

func takeDamage(damage:int) -> void:
	pv -= damage
	print(pv)
