extends PathFollow3D

@export var speed: float = 5
@export var damage: int = 1

@onready var base: Base = get_tree().get_first_node_in_group("base")

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1:
		base.takeDamage(damage)
		queue_free()
