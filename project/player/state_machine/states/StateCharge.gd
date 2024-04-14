class_name State_Fade extends State



var energy_timer : Timer=Timer.new()

func _ready():
	energy_timer.timeout.connect(_on_energy_timer)
	energy_timer.wait_time = .25
	energy_timer.one_shot = false
	add_child(energy_timer)

func enter(_msg := {}) -> void:
	player.player_skin.start_charging()	
	energy_timer.start()

func _on_energy_timer():
	AlEnergySystem.add_energy(player.player_movement_config.recover_energy_per_second )
	
func exit() -> void:
	energy_timer.stop()
	player.player_skin.stop_charging()
	pass



