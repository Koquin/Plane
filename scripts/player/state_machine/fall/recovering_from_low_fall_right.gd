extends State
class_name recovering_from_low_fall_right

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_recovering_from_low_fall.png")
	animator.play("fall/recovering_from_low_fall_right")
	parent.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	if (input.move_axis > 0):
		request_transition("running_right_right_step")
	else:
		await get_tree().create_timer(0.2).timeout
		request_transition("idle_2")
