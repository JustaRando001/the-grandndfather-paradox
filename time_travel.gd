extends Node

enum TimeState {PAST, PRESENT}

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
	print("The Present")
	
func switch_to_past():
	print("The Past")
