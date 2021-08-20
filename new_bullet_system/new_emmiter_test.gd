extends Node2D

onready var bullet_canvas = $Node/BulletDrawer
var is_firing : bool = false
var bullets_spawned = 14
var firerate : float

var actual_spaned : int

var bullets : Array


func set_firerate(new_firerate):
	firerate =  do_firerate_math(new_firerate)
	
func do_firerate_math(new_firerate):
	if new_firerate == 0:
		firerate = 1
	
	return 1 / new_firerate


func _ready():
	set_firerate(1)


func _process(delta)-> void:
	if Input.is_action_pressed("ui_accept"):
		if !is_firing :
			is_firing = true
			
			for i in bullets_spawned:
				var bullet_rotation = deg2rad(rand_range(-90, 90))
				var move_dir = get_global_mouse_position().normalized().rotated(bullet_rotation)
				bullets.append( bullet2.new(
						global_position,
						move_dir, 
						500.0, 
						bullet_rotation,

						# effects here
						[preload("res://new_bullet_system/bouncy_bullets.gd").new()]
						
						) 
						
					)

			yield(get_tree().create_timer(firerate), "timeout")
			is_firing = false
			
		
func _physics_process(delta)-> void:
	var bullets_that_must_be_destroyed : Array
	actual_spaned = bullets.size()

	for i in range(bullets.size()):
		var bullet = bullets[i] as bullet2
		
		bullet.update_positiion(delta)
	
		if bullet.do_collision(get_world_2d().direct_space_state):
			bullets_that_must_be_destroyed.append(bullet)
		
		bullet_canvas.bullets = bullets
		
		if bullet.update_lifetime(delta):
			bullets_that_must_be_destroyed.append(bullet)
	
	for i in range(bullets_that_must_be_destroyed.size()):
		var bullet = bullets_that_must_be_destroyed[i] as bullet2
		delete_bullets(bullet)
	


func delete_bullets(bullet :bullet2)-> void:
	bullets.erase(bullet)
	

