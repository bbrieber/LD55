class_name EnergySystem extends Node


var energy: Energy 


signal energy_changed(energy :Energy)



# Called when the node enters the scene tree for the first time.
func initialize(new_energy: Energy ):
	energy = new_energy
	energy_changed.emit(energy)


func get_current_energy():
	if not energy:
		return 0 
	return energy.current_energy
	
	
func get_max_energy()-> float:
	if not energy:
		return 0.0
	return energy.max_energy
	
func restore_energy():
	energy.current_energy = energy.max_energy
	energy_changed.emit(energy)
	

func reduce_energy(rel_energy :float )-> float:
	return _update_relative(-rel_energy)

func add_energy(rel_energy :float )-> float:
	return _update_relative(rel_energy)
		
func _update_relative(rel_energy :float )-> float:
	if not energy:
		return -1 
	var new_energy = energy.current_energy+rel_energy
	new_energy = max(0,new_energy)
	new_energy = min(energy.max_energy,new_energy)
	energy.current_energy = new_energy
	
	energy_changed.emit(energy)	
	return energy.current_energy
