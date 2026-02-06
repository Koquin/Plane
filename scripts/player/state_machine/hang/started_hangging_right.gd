extends State
class_name started_hangging_right

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 2
@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var ray_cast_dir_alto: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAlto"
@onready var ray_cast_esq_alto: RayCast2D = $"../../RayCastsHang/RayCast2DEsquerdoAlto"
@onready var ray_cast_dir_alto_baixo: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAltoBaixo"
@onready var ray_cast_esq_alto_baixo: RayCast2D = $"../../RayCastsHang/RayCast2DEsquerdoAltoBaixo"

func Enter() -> void:
	super()
		#Setting ray casts
	ray_cast_dir_alto.enabled = parent.is_facing_right
	ray_cast_esq_alto.enabled = not parent.is_facing_right
	ray_cast_dir_alto_baixo.enabled = parent.is_facing_right
	ray_cast_esq_alto_baixo.enabled = not parent.is_facing_right
	
	#Which direction is the player facing
	var horizontal_direction = 1 if parent.is_facing_right else -1
	
	#Getting the middle of the tile
	var _tileSize = parent.tileMap.tile_set.tile_size
	var _tileSizeCorrection = (_tileSize / 2) as Vector2
	
	#Where the ray cast collides
	var _collisionPoint
	
	#Global tile coordinates
	var _tileCoords
	
	#Local tile coordinates
	var local_point 
	#If the player is facing left
	if (!parent.is_facing_right):
		#If the player is facing a wall
		if (ray_cast_esq_alto_baixo.is_colliding()):
			#Gets the coordinates of the collision point
			_collisionPoint = ray_cast_esq_alto_baixo.get_collision_point()
			
			#Gets the local coordinates of the tile which the ray cast collided
			local_point = parent.tileMap.to_local(_collisionPoint)
			
			#Finds the tile in which the coordinates is
			_tileCoords = parent.tileMap.local_to_map(local_point)
			
			#Subtract one of the height, getting the tile below, so the player is aligned
			_tileCoords += Vector2i(0, 1)
			#Where the player will grab
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	#Same as above
	if (parent.is_facing_right):
		if (ray_cast_dir_alto_baixo.is_colliding()):
			_collisionPoint = ray_cast_dir_alto_baixo.get_collision_point()
			local_point = parent.tileMap.to_local(_collisionPoint)
			_tileCoords = parent.tileMap.local_to_map(local_point)
			_tileCoords += Vector2i(0, 1)
			cornerGrabPosition = parent.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	#Adjusting the player to the lateral of the tile instead of inside it. Adjusting the Y as well so its hands are in the right place.
	ledgeGrabSnapPosition = Vector2(cornerGrabPosition.x + (horizontal_direction * -1), cornerGrabPosition.y + ledgeGrabSnapY - 9)
	
	#Snap the player
	parent.global_position = ledgeGrabSnapPosition

	player.set_sprite("res://art/character/player_base_started_hangging.png")
	animator.play("hang/started_hangging_right")
	parent.velocity = Vector2.ZERO
	await animator.animation_finished
	request_transition("hangging")
func Physics_update(delta: float) -> void:
	super(delta)
