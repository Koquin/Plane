class_name TryingToHangState
extends State

var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 6
@onready var character_animation: AnimationPlayer
func Enter():
	character_animation = parent.get_node("Sprite2D/AnimationPlayer")
	character_animation.play("trying_to_hang")
	parent.get_node("RayCastsHang/RayCast2DDireitoAlto").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto").enabled = not parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").enabled = parent.is_facing_right
	parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").enabled = not parent.is_facing_right
	var horizontal_direction = 1 if parent.is_facing_right else -1
	var _tileSize = parent.tileMap.tile_set.tile_size
	var _tileSizeCorrection = (_tileSize / 2) as Vector2
	var _collisionPoint
	var _tileCoords
	if (!parent.is_facing_right):
		if (parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").is_colliding()):
			_collisionPoint = parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo").get_collision_point()
			_tileCoords = parent.tileMap.local_to_map(_collisionPoint)
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	if (parent.is_facing_right):
		if (parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").is_colliding()):
			_collisionPoint = parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").get_collision_point()
			_tileCoords = parent.tileMap.local_to_map(_collisionPoint)
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	
	ledgeGrabSnapPosition = Vector2(cornerGrabPosition.x + (horizontal_direction * -1), cornerGrabPosition.y + ledgeGrabSnapY)
	
func Physics_update(_delta):
	if parent.velocity.y > 0:
		parent.get_node("Sprite2D/AnimationPlayer").play("falling")
		
	if parent.is_on_floor():
		transitioned.emit("Idle")
		return
	
	var raycast_dir_alto = parent.get_node("RayCastsHang/RayCast2DDireitoAlto")
	var raycast_esq_alto = parent.get_node("RayCastsHang/RayCast2DEsquerdoAlto")
	
	var raycast_dir_alto_baixo = parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo")
	var raycast_esq_alto_baixo = parent.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo")
	
	if (raycast_dir_alto_baixo.enabled and raycast_dir_alto_baixo.is_colliding() and raycast_dir_alto.enabled and not raycast_dir_alto.is_colliding()) \
	or (raycast_esq_alto_baixo.enabled and raycast_esq_alto_baixo.is_colliding() and raycast_esq_alto.enabled and not raycast_esq_alto.is_colliding()):
		transitioned.emit("HanggingState")
