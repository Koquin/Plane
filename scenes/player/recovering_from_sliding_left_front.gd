extends State
class_name recovering_from_sliding_left_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("recovering_from_sliding/recovering_from_sliding_left_front")
	parent.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	if (input.down_pressed):
		request_transition("crouch_left_front")
	elif (input.move_axis < 0):
		print("entrou no input.move_axis < 0")
		request_transition("dashing_left_from_idle_3")
	request_transition("idle_3")
