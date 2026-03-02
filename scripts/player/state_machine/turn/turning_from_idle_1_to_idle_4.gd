extends State
class_name turning_from_idle_1_to_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var player := character
@export var apply_gravity := true

func Enter():
	super()
	animator.play("turn/turn_1_to_4")

func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	request_transition("idle_4")
	
