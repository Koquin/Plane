class_name trying_to_hang_left
extends State

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter():
	super()
	player.set_sprite("res://art/character/player_base_trying_to_hang.png")
	if (parent.is_facing_right):
		animator.play("hang/trying_to_hang_right")
	else: animator.play("hang/trying_to_hang_left")
	parent.get_node("RayCastsHang/RayCast2DDireitoAlto").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto").enabled = not parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").enabled = not parent.is_facing_right
	print(parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled)
	print(parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled)
	
func Physics_update(delta: float) -> void:
	super(delta)
	print("Velocidade de queda: %s" %parent.velocity.y)
	var raycast_dir_alto = parent.get_node("RayCastsHang/RayCast2DDireitoAlto")
	var raycast_esq_alto = parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto")
	
	var raycast_dir_alto_baixo = parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo")
	var raycast_esq_alto_baixo = parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo")
	
	if parent.is_on_floor():
		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		if parent.is_facing_right:
			request_transition("recovering_from_low_fall_right")
		else:
			request_transition("recovering_from_low_fall_left")
		return
	
	if parent.velocity.y > 500:
		raycast_dir_alto_baixo.target_position.y = max(0, abs(parent.velocity.y) * delta * 2)
		raycast_esq_alto_baixo.target_position.y = max(0, abs(parent.velocity.y) * delta * 2)

	if (raycast_dir_alto_baixo.enabled and raycast_dir_alto_baixo.is_colliding() and raycast_dir_alto.enabled and not raycast_dir_alto.is_colliding()) \
	or (raycast_esq_alto_baixo.enabled and raycast_esq_alto_baixo.is_colliding() and raycast_esq_alto.enabled and not raycast_esq_alto.is_colliding()):
		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		if parent.is_facing_right:
			request_transition("started_hangging_right")
		else:
			request_transition("started_hangging_left")
