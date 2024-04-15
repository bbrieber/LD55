extends Node2D


@export var dialogue : Dialogue
@export var label : StringName = "Interact"

var active:bool = false

# Called when the node enters the scene tree for the first time.
func interact():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_key_input(event):
	
	if not active:
		return
	if Input.is_action_just_pressed("interact"):
		AlDialogueSystem.send_dialogue_request(dialogue)
	
	


func _on_body_entered(body):
	active = true
	$DialogueTrigger/Label.visible = true
	$DialogueTrigger/Label.text = label


func _on_body_exited(body):
	active = false
	$DialogueTrigger/Label.visible = false
