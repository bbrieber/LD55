class_name  PlayerSoundManager extends Node

@export var fade_in_stream : AudioStream
@export var fade_out_stream : AudioStream
@export var jump_stream : AudioStream
@export var dash_stream : AudioStream 
@export var land_stream : AudioStream 

@onready var streamPlayer :AudioStreamPlayer = $AudioStreamPlayer

func play_jump_sound():
	streamPlayer.stream = jump_stream
	streamPlayer.play()

func play_dash_sound():
	streamPlayer.stream = dash_stream
	streamPlayer.play()


	
func play_fade_out_sound():
	streamPlayer.stream = fade_out_stream
	streamPlayer.play()
	
func play_fade_in_sound():
	streamPlayer.stream = fade_in_stream
	streamPlayer.play()

func play_land_sound():
	streamPlayer.stream = land_stream
	streamPlayer.play()
