class_name State_Move extends StateMovementBase


@export var wallRaycast: WallRaycast

func enter(_msg := {}) -> void:
	state_started.emit()
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.RUN)
	
func exit() -> void:	
	state_exit.emit()

#	if player.velocity.y>0:
#		player.player_state.coyote_timer.start()



func physics_update(_ownerBody: CharacterBody2D,delta: float) -> void:
	var horizontal_dir = player.input_processor.horizontal_dir
	if player.is_on_wall():
		if (wallRaycast.get_wall_dir() < 0 and horizontal_dir<0) or (wallRaycast.get_wall_dir() > 0 and horizontal_dir >0) :
			update_locomotion(0,delta)
			return
	update_locomotion(horizontal_dir,delta)
	
			
