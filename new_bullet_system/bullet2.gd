class_name bullet2
extends Object


var deletes_on_wall_hit : bool = true
var deletes_on_enemy_hit : bool = true
var deletes_on_ally_hit : bool = false
var deletes_on_defaut_hit : bool = true



var starting_position : Vector2
var current_positon : Vector2	
var move_dir: Vector2
var speed : float
var texture : Texture = preload("res://icon.png") 
var offset : Vector2
var max_lifetime :float = 3
var current_lifetime : float
var global_space_state : Physics2DDirectSpaceState
var hitbox : Shape2D
var effects : Array

signal hit_wall(collider, bullet)
signal hit_enemy(collider, bullet)
signal hit_ally(collider, bullet)


func _init(new_start : Vector2, new_move_dir : Vector2, new_speed : float,bullet_rotation :float, new_effects : Array = [])-> void:	
	effects = new_effects
	
	for effect in effects:
		effect.connect_stuff(self)
	
	starting_position = new_start
	move_dir = new_move_dir.normalized()
	speed = new_speed
	current_positon = starting_position
	offset = texture.get_size() / 2.0
	hitbox = CircleShape2D.new()
	hitbox.radius = 32
	


func do_collision(space_state : Physics2DDirectSpaceState)-> bool:
	global_space_state = space_state
	var shape_to_intersect : Physics2DShapeQueryParameters = Physics2DShapeQueryParameters.new()
	shape_to_intersect.set_shape(hitbox)
	
	shape_to_intersect.transform.origin = current_positon
	var results = space_state.intersect_shape(shape_to_intersect, 4)
	
	
	if results:
		for i in range(results.size()):
			var result :Dictionary = results[i] 
			return stuff_to_do_if_collided(result.collider)
			
	return false
	

func get_collision_data()-> Dictionary:
	var cast_end : Vector2 = current_positon + (move_dir * 500)
	var result = global_space_state.intersect_ray(current_positon, cast_end)
	return result


func stuff_to_do_if_collided(collision : Object)-> bool:
	if collision is TileMap:
		emit_signal("hit_wall", get_collision_data(), self)
		return deletes_on_wall_hit
	
	# TODO make it for enemies
	if true:
		emit_signal("hit_enemy",get_collision_data(), self)
		return deletes_on_enemy_hit
	
	# TODO do for allies
	if true:
		emit_signal("hit_ally",get_collision_data(), self)
		return deletes_on_ally_hit


	return deletes_on_defaut_hit




func update_lifetime(delta :float)-> bool:
	current_lifetime += delta
	return current_lifetime > max_lifetime
	

func update_positiion(delta : float)-> void:
	current_positon += move_dir.normalized() * speed * delta
