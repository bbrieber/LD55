extends Node

@onready var music_stream: AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	music_stream.play()




func _on_music_stream_player_finished():
	music_stream.play()
