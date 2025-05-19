extends CharacterBody2D

var state: String
var walk_distance: float = 64
var detected: bool
var gravity: float

signal distance_met

func _ready():
	gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
	detected= false
	connect('distance_met', Callable(self, '_get_my_stuff'))
	
func _physics_process(delta: float) -> void:
	match detected:
		true:
			velocity.x = walk_distance
		false:
			velocity.x = -walk_distance
	if not is_on_floor():
		velocity.y = gravity
	move_and_slide()
		
	
func _get_my_stuff():
	$walk_timer.start()

	 


func _on_entity_detection_body_entered(body: Node2D) -> void:
		emit_signal('distance_met')

func _on_entity_detection_body_exited(body: Node2D) -> void:
	pass


func _on_walk_timer_timeout() -> void:
		match detected:
			false:
				detected = true
			true:
				detected = false
