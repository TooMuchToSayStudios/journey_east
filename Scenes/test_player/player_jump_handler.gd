extends Node2D

var can_wall_jump: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	can_wall_jump = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_wall_jump_timer_timeout():
	can_wall_jump = true
