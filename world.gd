extends Node2D

enum TimeState {PAST, PRESENT}

@onready var past = $PastLayer
@onready var present = $PresentLayer

var current_time_state = TimeState.PAST

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
	present.enabled = true
	present.visible = true
	past.enabled = false
	past.visible = false
	
func switch_to_past():
	past.enabled = true
	past.visible = true
	present.enabled = false
	present.visible = false
