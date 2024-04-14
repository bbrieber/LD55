class_name State_Charge extends State




func enter(_msg := {}) -> void:
	player.player_skin.fade_away()
	player.player_state.start_fading()
	
func exit() -> void:
	#player.player_skin.stop_charging()
	pass



