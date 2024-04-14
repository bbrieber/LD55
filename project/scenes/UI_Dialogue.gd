extends Control

@export var test_dialog:Dialogue
@export var test_dialog_block:DialogBlock
@onready var spaeker_1 : Label = $NinePatchRect/Speaker_1
@onready var spaeker_2 : Label = $NinePatchRect/Speaker_2
@onready var text : Label = $NinePatchRect/Text

var current_dialogue : Dialogue
var current_dialogue_block : DialogBlock
func show_dialog_block(dialog_block : DialogBlock):
	get_tree().paused = true
	$NinePatchRect.visible = true
	
	if dialog_block.speaker == 1:
		spaeker_1.text = dialog_block.speaker_name
		spaeker_2.text = ""
	else:
		spaeker_2.text = dialog_block.speaker_name
		spaeker_1.text = ""
	text.text = dialog_block.text

func close_dialog():
	get_tree().paused = false
	$NinePatchRect.visible = false
# Called when the node enters the scene tree for the first time.
func _ready():
	play_dialog(test_dialog)
	
	

func play_dialog(dialogue : Dialogue):
	current_dialogue = dialogue
	next_dialog_block()
	
func next_dialog_block():
	current_dialogue_block = current_dialogue.dialog_blocks.pop_front()
	if current_dialogue_block:
		show_dialog_block(current_dialogue_block)
	else: 
		close_dialog()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("jump"):
		next_dialog_block()
