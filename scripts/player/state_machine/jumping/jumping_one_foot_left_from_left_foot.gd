extends State
class_name jumping_one_foot_left_from_left_foot

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("jump/jumping_one_foot_left_from_left_foot")
	if (character.is_on_floor()):
		if (character.velocity.x > -100):
			character.velocity.y = -160
			character.velocity.x = -100
		else:
			character.velocity.y = -160
	else:
		character.velocity.y = -130
		character.velocity.x = -130
		
func Physics_update(delta: float) -> void:
	super(delta)
	if (character.input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (character.velocity.y > 0):
		request_transition("low_falling_left")
