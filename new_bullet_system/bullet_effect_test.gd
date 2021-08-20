class_name BaseEffect

extends Object


enum TRIGGER_TYPE{
	ON_WALL_HIT,
	ON_ENEMY_HIT,
	ON_ALLY_HIT
	
}

var effect_types : Array


func _init()-> void:
	effect_types # = [insert desired trigger type here]

# automates conections
func connect_stuff(bullet)-> void:
	for effect_type in effect_types:
		match effect_type:
			TRIGGER_TYPE.ON_WALL_HIT:
				bullet.connect("hit_wall", self, "effect")
			TRIGGER_TYPE.ON_ENEMY_HIT:
				bullet.connect("hit_enemy", self, "effect")
			TRIGGER_TYPE.ON_ALLY_HIT:
				bullet.connect("hit_ally", self, "effect")


# detects to see if the effect should work
func effect_condition(collision :Dictionary, bullet)-> bool:
	return true
	

func effect(collision :Dictionary, bullet)-> void:
	if effect_condition(collision, bullet):
		actual_effect(collision, bullet)
		
		
func actual_effect(collision :Dictionary, bullet)-> void:
	pass
	# do effect code here
