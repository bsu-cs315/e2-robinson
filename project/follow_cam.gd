extends Camera2D


@export var target: Node2D


func _ready() -> void:
	assert(target != null, "No target set")
	global_position = target.global_position


func _physics_process(_delta: float) -> void:
	global_position = lerp(global_position, target.global_position, .2)
