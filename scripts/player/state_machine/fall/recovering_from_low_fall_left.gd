extends State
class_name recovering_from_low_fall_left

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_recovering_from_low_fall.png")
	animator.play("fall/recovering_from_low_fall_left")
	parent.velocity.x = 0

func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	request_transition("idle_3")
