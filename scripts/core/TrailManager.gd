extends Node

enum IntentType {
	JUMP_PRESS,
	DOWN_PRESS,
	DOWN_RELEASE,
	MOVE_LEFT,
	MOVE_RIGHT,
	MOVE_UP,
	MOVE_DOWN
}

class TrailEntry:
	var position : Vector2
	var intent_type : int
	var direction : int
	var timestamp : float
	var max_age : float
	
	func _init(_position, _intent_type, _direction, _timestamp, _max_age):
		position = _position
		intent_type = _intent_type
		direction = _direction
		timestamp = _timestamp
		max_age = _max_age

	func is_expired(current_time: float) -> bool:
		return current_time - timestamp > max_age
