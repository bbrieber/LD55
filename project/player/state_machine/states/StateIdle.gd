class_name State_Idle extends StateMovementBase






func enter(_msg := {}) -> void:
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.IDLE)
	
	
func exit() -> void:
	pass



