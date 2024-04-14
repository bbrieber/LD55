extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	AlEnergySystem.energy_changed.connect(_energy_changed)
	max_value = AlEnergySystem.get_max_energy()
	value = AlEnergySystem.get_current_energy()

func _energy_changed(_energy : Energy):
	max_value = AlEnergySystem.get_max_energy()
	value = AlEnergySystem.get_current_energy()
	
	
	
