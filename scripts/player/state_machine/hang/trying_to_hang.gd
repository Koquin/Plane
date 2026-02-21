class_name trying_to_hang_left
extends State

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
var facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@export var apply_gravity := true

func Enter():
	super()
	facing_right = character.is_facing_right
	if (character.is_facing_right):
		animator.play("hang/trying_to_hang_right")
	else: animator.play("hang/trying_to_hang_left")
	character.get_node("RayCastsHang/RayCast2DDireitoAlto").enabled = character.is_facing_right
	character.get_node("RayCastsHang/RayCast2DEsquerdoAlto").enabled = not character.is_facing_right
	character.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled = character.is_facing_right
	character.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").enabled = not character.is_facing_right
	character.get_node("RayCastsHang/RayCast2DDireitoMeio").enabled = character.is_facing_right
	character.get_node("RayCastsHang/RayCast2DEsquerdoMeio").enabled = not character.is_facing_right
	print("Raycast direito alto: %s" %character.get_node("RayCastsHang/RayCast2DDireitoAlto").enabled)
	print("Raycast direito baixo: %s" %character.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled)

func Physics_update(delta: float) -> void:
	super(delta)
	if ((raycast_dir_alto_baixo.enabled and not raycast_dir_alto_baixo.is_colliding()) and (raycast_dir_meio.enabled and raycast_dir_meio.is_colliding())) \
	or (raycast_esq_alto_baixo.enabled and not raycast_esq_alto_baixo.is_colliding() and raycast_esq_meio.enabled and raycast_esq_meio.is_colliding()):
		print("Raycast dir meio colidindo ?: %s" %raycast_dir_meio.is_colliding())
		print("Raycast esq meio colidindo ?: %s" %raycast_esq_meio.is_colliding())

		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		if character.is_facing_right:
			print("Indo para o climbing_right_fast")
			request_transition("climbing_right_faster")
		else:
			print("Indo para o climbing_left_fast")
			request_transition("climbing_left_faster")

	elif ((raycast_dir_alto_baixo.enabled and raycast_dir_alto_baixo.is_colliding()) and (raycast_dir_alto.enabled and not raycast_dir_alto.is_colliding())) \
	or (raycast_esq_alto_baixo.enabled and raycast_esq_alto_baixo.is_colliding() and raycast_esq_alto.enabled and not raycast_esq_alto.is_colliding()):
		print("Raycast dir_alto_baixo colidindo ?: %s" %raycast_dir_alto_baixo.is_colliding())
		print("Raycast dir_alto colidindo ?: %s" %raycast_dir_alto.is_colliding())
		print("Raycast esq_alto_baixo colidindo ?: %s" %raycast_esq_alto_baixo.is_colliding())
		print("Raycast esq_alto colidindo ?: %s" %raycast_esq_alto.is_colliding())

		raycast_dir_alto_baixo.target_position.y = 0
		raycast_esq_alto_baixo.target_position.y = 0
		if character.is_facing_right:
			print("Indo para o hangging right")
			request_transition("started_hangging_right")
		else:
			print("Indo para o hangging left")
			request_transition("started_hangging_left")

	elif character.is_on_floor():
		print("Recuperando da queda")
		if character.is_facing_right:
			request_transition("recovering_from_low_fall_right")
		else:
			request_transition("recovering_from_low_fall_left")
	
	elif character.velocity.y > 100:
		raycast_dir_alto_baixo.target_position.y = max(0, abs(character.velocity.y) * delta * 2)
		raycast_esq_alto_baixo.target_position.y = max(0, abs(character.velocity.y) * delta * 2)

func Exit():
	raycast_dir_alto_baixo.target_position.y = 0
	raycast_esq_alto_baixo.target_position.y = 0
	
