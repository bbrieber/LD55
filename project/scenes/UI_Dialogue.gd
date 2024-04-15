class_name DialogueController extends Control

@export var test_dialog:Dialogue
@export var test_dialog_block:DialogBlock
@onready var spaeker_1 : Label = $NinePatchRect/Speaker_1
@onready var spaeker_2 : Label = $NinePatchRect/Speaker_2
@onready var text : Label = $NinePatchRect/Text
@onready var holder : Control = $NinePatchRect


func _ready():
	AlDialogueSystem.play_dialogue_request.connect(play_dialog)

var current_dialogue : Dialogue
var current_dialogue_block : DialogBlock
var active : bool = false

func show_dialog_block(dialog_block : DialogBlock):
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
	holder.visible = false
	active = false

func play_dialog(dialogue : Dialogue):
	get_tree().paused = true
	holder.visible = true
	current_dialogue = dialogue
	active = true
	#show_dialog_block(current_dialogue.dialog_blocks.pop_front())
	
func next_dialog_block():
	current_dialogue_block = current_dialogue.dialog_blocks.pop_front()
	if current_dialogue_block:
		print("showing Dialog")
		show_dialog_block(current_dialogue_block)
	else: 
		close_dialog()


	
func _unhandled_input(_event):
	if active and Input.is_action_just_pressed("interact"):
		next_dialog_block()
