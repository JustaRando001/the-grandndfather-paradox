extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

@onready var _animated_sprite = $AnimatedSprite2D

func _process(delta):
	if Input.is_action_pressed("right"):
		_animated_sprite.flip_h = false
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("left"):
		_animated_sprite.flip_h = true
		_animated_sprite.play("walk") 
	else:
		_animated_sprite.play("idle")
		

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	
