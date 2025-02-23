extends Node2D

@onready var past = $PastLayer
@onready var present = $PresentLayer

@onready var supportedPillar = Image.load_from_file("res://assets/supportedPillar.png")
@onready var collapsedPillar = Image.load_from_file("res://assets/collapsedPillar.png")
@onready var supportedPillarTex = ImageTexture.create_from_image(supportedPillar)
@onready var collapsedPillarTex = ImageTexture.create_from_image(collapsedPillar)
@onready var supportedPillarArea = load("res://shapes/supportedPillarShape.tres")
@onready var collapsedPillarArea = load("res://shapes/collapsedPillarShape.tres")

var current_time_state = TimeState.PAST

signal time_state_toggled(current_time_state : TimeState)

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
	time_state_toggled.emit(current_time_state)

func switch_to_present():
	present.visible = true
	present.propagate_call("set", ["disabled", false])
	
	# If the player solved the puzzle by placing the rock on the sapling
	if $PastLayer/Sapling.overlaps_body($ConstantLayer/BigRock):
		# Show collapsed pillar instead of supported pillar
		$PresentLayer/CollapsedOrSupportedPillar/CollapsedOrSupportedPillar.texture = collapsedPillarTex
		$PresentLayer/CollapsedOrSupportedPillar/CollapsedOrSupportedPillarArea.shape = collapsedPillarArea
		$PresentLayer/CollapsedOrSupportedPillar.transform.origin = Vector2(742, 69)
		# Do not show or collide with tree
		$PresentLayer/BigTree.visible = false
		$PresentLayer/BigTree/CollisionShape2D.disabled = true
	else:
		# If the player has not solved or unsolved the puzzle, undo everything
		$PresentLayer/CollapsedOrSupportedPillar/CollapsedOrSupportedPillar.texture = supportedPillarTex
		$PresentLayer/CollapsedOrSupportedPillar/CollapsedOrSupportedPillarArea.shape = supportedPillarArea
		$PresentLayer/CollapsedOrSupportedPillar.transform.origin = Vector2(742, 60)
		$PresentLayer/BigTree.visible = true
		$PresentLayer/BigTree/CollisionShape2D.disabled = false
	
	past.visible = false
	past.propagate_call("set", ["disabled", true])
	
func switch_to_past():
	past.visible = true
	past.propagate_call("set", ["disabled", false])
	
	present.visible = false
	present.propagate_call("set", ["disabled", true])
