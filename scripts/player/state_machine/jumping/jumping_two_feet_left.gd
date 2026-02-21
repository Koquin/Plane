extends State
class_name jumping_two_feet_left

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("jump/jumping_two_feet_left")
	character.velocity.y = -220
	character.velocity.x = -20
func Physics_update(delta: float) -> void:
	super(delta)
	if (character.input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (character.velocity.y > 0):
		request_transition("low_falling_left")
