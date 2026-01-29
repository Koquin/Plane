extends State
class_name turning_from_idle_2_to_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var player := $"../../../Player"

func Enter():
	super()
	player.set_sprite("res://art/character/player_base_turn.png")
	animator.play("turn/turn_2_to_4")
func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	request_transition("idle_4")
