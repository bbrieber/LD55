class_name SpawnPoint extends Node2D


@export var map_manager : MapManager

signal on_respawn

func respawn():
	on_respawn.emit()
	
	
func _on_body_entered(body):
	if body is Player:
		map_manager.set_spawn_point(self)
	else:
		print("Unexspected collission Body") # Replace with function body.
