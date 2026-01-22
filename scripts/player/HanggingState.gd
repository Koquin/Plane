class_name HanggingState
extends State

var is_looking_back := false
var character_animation = AnimationPlayer
var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 6
@onready var input := $"../../PlayerInput"

func Enter():
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
			var local_point = parent.tileMap.to_local(_collisionPoint)
			_tileCoords = parent.tileMap.local_to_map(local_point)
			_tileCoords += Vector2i(0, 1)
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	if (parent.is_facing_right):
		if (parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").is_colliding()):
			_collisionPoint = parent.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo").get_collision_point()
			var local_point = parent.tileMap.to_local(_collisionPoint)
			_tileCoords = parent.tileMap.local_to_map(local_point)
			_tileCoords += Vector2i(0, 1)
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	ledgeGrabSnapPosition = Vector2(cornerGrabPosition.x + (horizontal_direction * -1), cornerGrabPosition.y + ledgeGrabSnapY - 2)
	parent.global_position = ledgeGrabSnapPosition
	parent.velocity = Vector2.ZERO
	character_animation = parent.get_node("Sprite2D/AnimationPlayer")
	character_animation.play("hangging")
func Physics_update(_delta):
	if (input.move_axis == -1) and parent.is_facing_right and not is_looking_back:
		transitioned.emit("LookingBackState")
			
	elif (input.move_axis == 1) and not parent.is_facing_right and not is_looking_back:
		transitioned.emit("LookingBackState")

	if input.down_pressed:
		transitioned.emit("FallingState")
