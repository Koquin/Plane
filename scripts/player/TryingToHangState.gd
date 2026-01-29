class_name TryingToHangState
extends State
@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
	animator.play("trying_to_hang")
	parent.get_node("RayCastsHang/RayCast2DDireitoAlto").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto").enabled = not parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").enabled = not parent.is_facing_right
	print(parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled)
	print(parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled)
	
func Physics_update(_delta):
	print("Velocidade de queda: %s" %parent.velocity.y)
	var raycast_dir_alto = parent.get_node("RayCastsHang/RayCast2DDireitoAlto")
	var raycast_esq_alto = parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto")
	
	var raycast_dir_alto_baixo = parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo")
	var raycast_esq_alto_baixo = parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo")
	if parent.velocity.y > 0:
		parent.get_node("Sprite2D/AnimationPlayer").play("falling")
		
	if parent.is_on_floor():
		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		transitioned.emit("Idle")
		return
	
	if parent.velocity.y > 500:
		raycast_dir_alto_baixo.target_position.y = max(0, abs(parent.velocity.y) * _delta * 2)
		raycast_esq_alto_baixo.target_position.y = max(0, abs(parent.velocity.y) * _delta * 2)

	if (raycast_dir_alto_baixo.enabled and raycast_dir_alto_baixo.is_colliding() and raycast_dir_alto.enabled and not raycast_dir_alto.is_colliding()) \
	or (raycast_esq_alto_baixo.enabled and raycast_esq_alto_baixo.is_colliding() and raycast_esq_alto.enabled and not raycast_esq_alto.is_colliding()):
		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		transitioned.emit("HanggingState")
