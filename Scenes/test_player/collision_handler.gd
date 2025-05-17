extends CollisionShape2D

@export var state_handler: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state_handler.movement_state: #should match and make that collision samller when jumping to show tha the character is balled up
		'falling':
			self.scale = Vector2(1, 1)
		'1':
			self.scale = Vector2(1,1)
		'-1': 
			self.scale = Vector2(1,1)
		'no move':
			self.scale = Vector2(1, 1)
