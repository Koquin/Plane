extends InputProvider
class_name SoldierInput

var character : Base_Character
var target : Node2D
var stop_distance := 0

func update(delta):
	if target == null:
		print("target ou character nulo")
		move_axis = 0
		return
		
	var dx = target.global_position.x - character.global_position.x

	if abs(dx) > stop_distance:
		move_axis = sign(dx)
	else:
		move_axis = 0
