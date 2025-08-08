extends PathFollow3D

@export var speed: float = 5
@export var damage: int = 1
@export var attack_delay: float = 1.0
var attack_timeout: float = 0

@onready var base: Base = get_tree().get_first_node_in_group("base")

func _ready() -> void:
	attack_timeout = attack_delay

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1:
		attack_timeout -= delta
		if attack_timeout <= 0:
			attack_timeout = attack_delay
			base.takeDamage(damage)
