class_name State_Idle extends StateMovementBase



#var energy_timer : Timer=Timer.new()
#
#func _ready():
#	energy_timer.timeout.connect(_on_energy_timer)
#	energy_timer.wait_time = 1
#	energy_timer.one_shot = false
#	add_child(energy_timer)

func enter(_msg := {}) -> void:
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.IDLE)
	
#	energy_timer.start()

func _on_energy_timer():
	AlEnergySystem.add_energy(player.player_movement_config.recover_energy_per_second)
	
func exit() -> void:
#	energy_timer.stop()
	pass



