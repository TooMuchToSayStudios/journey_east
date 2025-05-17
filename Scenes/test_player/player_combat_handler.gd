extends Node2D

@export var parent: Node
@export var state_handler: Node
@export var attack_box_location_right: Node
@export var attack_box_location_left: Node

#list of box shapes to queue free
var attack_shapes: Array

#combat signals
signal air_dash_started

func _ready():
	connect('air_dash_started', Callable(self, '_on_air_dash_start'))
	
func _physics_process(delta: float) -> void:
	downward_thrust()
	air_dash()


func downward_thrust():
	if state_handler.movement_state == 'jumping' or state_handler.movement_state == 'falling':
		if Input.is_action_pressed('heavy attack'):
			state_handler.emit_signal('state_changed', 'movement_state', 'downward thrust')
			parent.velocity = Vector2(0, parent.gravity)
			var thrust_box = Area2D.new()
			var thrust_box_shape = CollisionShape2D.new()
			parent.add_child(thrust_box)
			thrust_box.add_child(thrust_box_shape)
			var rectangle_shape = RectangleShape2D.new()
			rectangle_shape.size = Vector2(32, 32) 
			thrust_box_shape.shape = rectangle_shape
			match parent.previous_direction: #checks the direction and puts that box in the facing direction
				1.0:
					thrust_box.position = attack_box_location_right.position
				-1.0:
					thrust_box.position = attack_box_location_left.position
			if thrust_box not in attack_shapes:
				attack_shapes.append(thrust_box)
			if thrust_box_shape not in attack_shapes:
				attack_shapes.append(thrust_box_shape)
			print('heavy attacking')
	if parent.is_on_floor():
		for node in attack_shapes:
			node.queue_free()
			attack_shapes = []

func air_dash():
	if state_handler.movement_state == 'jumping' or state_handler.movement_state == 'falling':
		if Input.is_action_just_pressed('light attack'):
			parent.velocity = Vector2(parent.velocity.x * parent.agility, parent.velocity.y)
			emit_signal('air_dash_started')

func _on_air_dash_started():
	await get_tree().create_timer(0.5).timeout
	parent.velocity.x = parent.direction
			
			
