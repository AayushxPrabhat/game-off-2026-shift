extends CharacterBody2D
@export var Speed  = 400
var dir = 0
@export var Force = 80

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = -400
	
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -Speed
	if Input.is_action_pressed("right"):
		velocity.x = Speed
	
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*Force)
