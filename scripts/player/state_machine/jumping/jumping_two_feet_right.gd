extends State
class_name jumping_two_feet_right

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_jumping_two_feet.png")
	animator.play("jump/jumping_two_feet_right")
	parent.velocity.y = -220
	parent.velocity.x = 20

func Physics_update(delta: float) -> void:
	super(delta)
	if (input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (parent.velocity.y > 0):
		request_transition("low_falling_right")
