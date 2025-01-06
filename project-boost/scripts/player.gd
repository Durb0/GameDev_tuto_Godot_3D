extends Node3D

var value: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("coucou")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		print("spacebar was pressed!")
		value += 3
		print(value)
