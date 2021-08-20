extends BaseEffect


func _init():
	effect_types = [TRIGGER_TYPE.ON_WALL_HIT]

func effect_condition(collision :Dictionary, bullet)-> bool:
	if collision:
		return true
	return false
		
		
func actual_effect(collision :Dictionary, bullet)-> void:
	bullet.deletes_on_wall_hit = false
	bullet.move_dir = bullet.move_dir.bounce(collision.normal)
