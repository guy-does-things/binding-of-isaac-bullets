extends Node2D

var bullets : Array


func _process(delta):
	update()

func _draw()-> void:
	for i in range(bullets.size()):
		var bullet = bullets[i] as bullet2
		draw_texture(bullet.texture, bullet.current_positon - bullet.offset )
