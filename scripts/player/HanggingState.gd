class_name HanggingState
extends State

var is_looking_back := false
var character_animation = AnimationPlayer
var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 6

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
	ledgeGrabSnapPosition = Vector2(cornerGrabPosition.x + (horizontal_direction * -1), cornerGrabPosition.y + ledgeGrabSnapY - 9)
	parent.global_position = ledgeGrabSnapPosition
	parent.velocity = Vector2.ZERO
	character_animation = parent.get_node("Sprite2D/AnimationPlayer")
	character_animation.play("hangging")
func Physics_update(_delta):
	var move_left  = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var move_down  = Input.is_action_just_pressed("move_down")
	var move_up = Input.is_action_just_pressed("move_up")
	var jump = Input.is_action_just_pressed("jump")
	if move_left and parent.is_facing_right and not is_looking_back:
		is_looking_back = true
		character_animation.play("starting_hangging_and_looking_back")
		print("[Looking back]")
			
	elif move_right and not parent.is_facing_right and not is_looking_back:
		is_looking_back = true
		character_animation.play("starting_hangging_and_looking_back")
		print("[Looking back]")
	
	if is_looking_back and move_right and parent.is_facing_right:
		is_looking_back = false
		print("[Facing the wall]")
		character_animation.play("hangging")
		
	elif is_looking_back and move_left and not parent.is_facing_right:
		is_looking_back = false
		print("[Facing the wall]")
		character_animation.play("hangging")
	
	if is_looking_back and jump:
		transitioned.emit("JumpingFromHanggingState")
	if move_up:
		transitioned.emit("ClimbingLedgeState")
	# Se apertar para baixo → cai
	if move_down:
		transitioned.emit("FallingState")
