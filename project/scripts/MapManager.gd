class_name MapManager extends Node


@export var player : Player
@export var initial_spawn_point : SpawnPoint


var current_spawn_point : SpawnPoint

func _ready():
	current_spawn_point = initial_spawn_point

func set_spawn_point(spawn_point : SpawnPoint):
	current_spawn_point = spawn_point


func _on_player_respawn():
	player.position = current_spawn_point.global_position
