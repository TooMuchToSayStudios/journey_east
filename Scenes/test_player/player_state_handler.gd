@tool
extends Node2D

var movement_state: String
var animation_state: String
var jump_state: String

signal state_changed(stateName, state)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('state_changed', Callable(self, '_on_state_changed'))


func _on_state_changed(stateName, state):
	print(stateName, ": ", state)
	match stateName:
		'movement_state': #left, right, none
			movement_state = state
			
		'animation_state': #walking, running, falling, jumping
			animation_state = state
		
		'jump_state': #jumping, jump done, falling
			jump_state = state
