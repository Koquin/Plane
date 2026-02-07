extends State
class_name jumping_one_foot_left_from_right_foot

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_jumping_one_foot.png")
	animator.play("jump/jumping_one_foot_left_from_right_foot")
	parent.velocity.y = -170
	
func Physics_update(delta: float) -> void:
	super(delta)
	if (input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (parent.velocity.y > 0):
		request_transition("low_falling_left")
