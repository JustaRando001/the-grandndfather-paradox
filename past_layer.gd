extends Node2D

@onready var platforms = [$FloatingPlatform, $FloatingPlatform2, $FloatingPlatform3]
@export_range(5.0, 30.0) var platform_speed
var original_platform_xs = []
@export var max_distance = 40
var moving_right = true

func _ready():
	for platform in platforms:
		original_platform_xs.append(platform.transform.origin.x)

func _physics_process(delta):
	# skip all logic if not visible
	if not visible:
		return

	
	if moving_right:
		for platform in platforms:
			platform.transform.origin.x += delta * platform_speed
		if platforms[0].transform.origin.x - original_platform_xs[0] > max_distance:
			moving_right = false
	else:
		for platform in platforms:
			platform.transform.origin.x -= delta * platform_speed
		if platforms[0].transform.origin.x - original_platform_xs[0] < 0:
			moving_right = true
		


func _on_world_time_state_toggled(current_time_state):
	if current_time_state == TimeState.PAST:
		moving_right = true
		for i in platforms.size():
			platforms[i].transform.origin.x = original_platform_xs[i]
