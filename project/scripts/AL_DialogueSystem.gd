class_name DialogueSystem extends Node


signal play_dialogue_request(dialogue :Dialogue)

func send_dialogue_request(dialogue :Dialogue):
	play_dialogue_request.emit(dialogue.duplicate(true))
	

