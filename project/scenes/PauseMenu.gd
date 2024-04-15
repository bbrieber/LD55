extends ColorRect

var is_active: bool = false

func _ready():
	visible = false
	
func activate_menu():
	get_tree().paused = true
	is_active = true
	visible = true
	
func deactivate_menu():
	get_tree().paused = false
	is_active = false
	visible = false
	
func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if is_active:
			deactivate_menu()
		else:
			activate_menu()
