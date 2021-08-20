extends Node2D

onready var fpslabel = $CanvasLayer/VBoxContainer/HBoxContainer/Label
onready var fireratelabel = $CanvasLayer/VBoxContainer/HBoxContainer2/Label2
onready var gun = $Node2D


var bullets_to_draw : Array





# Called when the node enters the scene tree for the first time.
func _ready():
	OS.vsync_enabled  = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fpslabel.text = str("FPS: ", Engine.get_frames_per_second()," Bullets spawned: " ,gun.actual_spaned, " pellets shot:", gun.bullets_spawned)
	
	
func _on_HSlider_value_changed(value):
	fireratelabel.text = str("Firerate ", value)
	gun.set_firerate(value)


func _on_HSlider2_value_changed(value):
	gun.bullets_spawned = value
