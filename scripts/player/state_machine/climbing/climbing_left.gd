extends State
class_name climbing_left

var climbingLedgeFinalPosition = Vector2.ZERO
const ledgeClimbPositionY = -19
@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"


@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@export var apply_gravity := false

func Enter():
	super()
	var horizontal_direction = 1 if character.is_facing_right else -1
	climbingLedgeFinalPosition = character.global_position + Vector2(10 * horizontal_direction, ledgeClimbPositionY)
	animator.play("climbing/climbing_left")
	await get_tree().create_timer(0.2).timeout
	character.global_position = climbingLedgeFinalPosition

func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	request_transition("idle_4")
