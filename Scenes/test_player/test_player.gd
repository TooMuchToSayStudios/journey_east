extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#rough stats
var agility: int = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#direction for calling in other objects
var direction: float
var previous_direction: float

#handler export
@export var state_handler: Node


func _physics_process(delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right") #direction is -1 or 1
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		state_handler.emit_signal('state_changed', 'jumping_state', 'falling')
		state_handler.emit_signal('state_changed', 'movement_state', 'falling')
		

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity = Vector2(direction * SPEED , JUMP_VELOCITY)
		state_handler.emit_signal('state_changed', 'jumping_state', 'jumping')
		state_handler.emit_signal('state_changed', 'movement_state', 'jumping')
		
	# Get the input direction and handle the movement/deceleration.
	
	if direction and $state_handler.movement_state != 'jumping' and $state_handler.movement_state != 'falling':
		state_handler.emit_signal('state_changed', 'movement_state', str(direction))
		velocity.x = direction * SPEED
		match direction:
			1.0:
				previous_direction = 1.0
			-1.0:
				previous_direction = -1.0
		
	else: #handles maintaining the velocity.x for the jump 
		if $state_handler.movement_state != 'falling' and $state_handler.movement_state != 'jumping':
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			state_handler.emit_signal('state_changed', 'movement_state', 'no move')
	#LETS PUT IT IN THE PLAYERS HANDS WHETHER THEY WANT TO WALL GRAB
	if is_on_wall() and $jump_handler.can_wall_jump == true and Input.is_action_pressed('wall_grab'): #is_on_wall shenanigans for seeing if i can use custom timers to jump off the wall
		velocity = Vector2.ZERO 
		if Input.is_action_just_pressed("ui_accept"):
			$jump_handler.can_wall_jump = false
			$wall_jump_timer.start()
			velocity = Vector2(direction * SPEED, JUMP_VELOCITY)
			state_handler.emit_signal('state_changed', 'jumping_state', 'jumping')
			state_handler.emit_signal('state_changed', 'movement_state', 'jumping')
	move_and_slide()
