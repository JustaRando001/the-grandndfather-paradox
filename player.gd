extends CharacterBody2D

enum TimeState {PAST, PRESENT}
const SPEED = 600.0
const JUMP_VELOCITY = -400.0
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

@onready var _animated_sprite = $AnimatedSprite2D

var current_time_state = TimeState.PAST

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
	
func _input(event):
	if event.is_action_pressed("time_swap"):
		toggle_time_state()
		
func toggle_time_state():
	if current_time_state == TimeState.PAST:
		current_time_state = TimeState.PRESENT
		switch_to_present()
	else:
		current_time_state = TimeState.PAST
		switch_to_past()
		
func switch_to_present():
	print("The Present")
	
func switch_to_past():
	print("The Past")
