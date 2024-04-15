extends Node2D


@export var dialogue : Dialogue
@export var label : StringName = "Interact"
@onready var _label :Label = $DialogueTrigger/Label
var active:bool = false
# Called when the node enters the scene tree for the first time.
func interact():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	
	if not active:
		return
	if event.is_action_pressed("interact"):
		AlDialogueSystem.send_dialogue_request(dialogue)
	
	


func _on_body_entered(_body):
	active = true
	if _label:
		_label.visible = true
		_label.text = label


func _on_body_exited(_body):
	active = false
	_label.visible = false
