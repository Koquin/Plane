extends State
class_name started_hangging_right

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 2
@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var ray_cast_dir_alto: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAlto"
@onready var ray_cast_dir_alto_baixo: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAltoBaixo"
@export var apply_gravity := false

func Enter() -> void:
	super()
	ledgeGrabSnapPosition = Vector2.ZERO
		#Setting ray casts
	ray_cast_dir_alto.enabled = character.is_facing_right
	ray_cast_dir_alto_baixo.enabled = character.is_facing_right
	
	#Which direction is the player facing
	var horizontal_direction = 1 if character.is_facing_right else -1
	
	#Getting the middle of the tile
	var _tileSize = character.tileMap.tile_set.tile_size
	var _tileSizeCorrection = (_tileSize / 2) as Vector2
	
	#Where the ray cast collides
	var _collisionPoint
	
	#Global tile coordinates
	var _tileCoords
	
	#Local tile coordinates
	var local_point
	if (character.is_facing_right):
		print("Entrou no character is facing right")
		_collisionPoint = ray_cast_dir_alto_baixo.get_collision_point()
		local_point = character.tileMap.to_local(_collisionPoint)
		_tileCoords = character.tileMap.local_to_map(local_point)
		_tileCoords += Vector2i(0, 1)
		cornerGrabPosition = character.tileMap.map_to_local(_tileCoords) - _tileSizeCorrection
	#Adjusting the player to the lateral of the tile instead of inside it. Adjusting the Y as well so its hands are in the right place.
	ledgeGrabSnapPosition = Vector2(cornerGrabPosition.x + (horizontal_direction * -1), cornerGrabPosition.y + ledgeGrabSnapY - 9)
	
	#Snap the player
	character.global_position = ledgeGrabSnapPosition

	animator.play("hang/started_hangging_right")
	character.velocity = Vector2.ZERO
	await animator.animation_finished
	request_transition("hangging")

func Physics_update(delta: float) -> void:
	super(delta)
