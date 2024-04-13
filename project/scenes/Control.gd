extends Control


@export var player : Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBox/FPS.text = "FPS " +str( Engine.get_frames_per_second() )
	$VBox/IsClimbing.text = "Climb " + str( player.player_state.is_climbing() )
	$VBox/Pos.text = "Pos " + str( player.position )
	$VBox/Vel.text = "Vel " + str( player.velocity )
