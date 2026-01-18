extends State
class_name idle_facing_right_right_foot_front

func Enter():
	parent.velocity.x += 40
	
func Physics_update(delta: float) -> void:
	pass
