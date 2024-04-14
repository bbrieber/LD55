class_name State_Wall extends State


@export var wallRaycast: WallRaycast

func enter(_msg := {}) -> void:
	state_started.emit()
	player.player_skin.set_view_direction(wallRaycast.get_wall_dir())
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.WALL_SLIDE)
	player.player_state.start_climb( )
	
func exit() -> void:	
	state_exit.emit()
	player.player_state.stop_climb( )

#	if player.velocity.y>0:
#		player.player_state.coyote_timer.start()

