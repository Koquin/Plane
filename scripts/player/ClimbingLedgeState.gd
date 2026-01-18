extends State
class_name climbing_ledge_state

var climbingLedgeFinalPosition = Vector2.ZERO
const ledgeClimbPositionY = -30
var character_animator = AnimationPlayer

func Enter():
	character_animator = parent.get_node("Sprite2D/AnimationPlayer")
	var horizontal_direction = 1 if parent.is_facing_right else -1
	climbingLedgeFinalPosition = parent.global_position + Vector2(10 * horizontal_direction, ledgeClimbPositionY)
	character_animator.play("climbing_ledge")
	await get_tree().create_timer(0.3999).timeout
	parent.global_position = climbingLedgeFinalPosition
	transitioned.emit("IdleState")

func Physics_update(delta: float) -> void:
	pass
