extends Node2D

@export var state_handler: Node
@export var anim: Node
# Called when the node enters the scene tree for the first time.
var previous_state: String

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state_handler.movement_state:
		'1':
			anim.flip_h = false
			anim.play('walking')
			previous_state = '1'
		'-1.0':
			anim.flip_h = true
			anim.play('walking')
			previous_state = '-1'
		'1.0':
			anim.flip_h = false
			anim.play('walking')
			previous_state = '1'
		'-1':
			anim.flip_h = true
			anim.play('walking')
			previous_state = '-1'
		'no move':
			anim.play('no move')
			previous_state = 'no move'
		'jumping':
			anim.play('jump start', 0, true)
			previous_state = 'jumping'
		'falling':
			anim.play('jump end', 0, true)
			previous_state = 'falling'
	match state_handler.jump_state:
		'jumping':
			anim.play('jump started')
		'falling':
			anim.play('jump ended')
