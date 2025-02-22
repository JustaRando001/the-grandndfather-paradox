extends Control

@onready var canvas = $CanvasModulate
@onready var pause_menu = $handle/Player/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if canvas.visible == false:
			canvas.visible = true
			pause_menu.visible = true
			get_tree().paused = true
		else:
			canvas.visible = false
			pause_menu.visible = false
			get_tree().paused = false


func _on_resume_button_pressed():
	canvas.visible = false
	pause_menu.visible = false
	get_tree().paused = false


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://settings_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
