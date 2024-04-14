class_name EnergyBall extends Area2D

@export var energy : float = 5

func _on_body_entered(body):
	if body is Player:
		AlEnergySystem.add_energy(energy)
		queue_free()
	else:
		print("Unexspected collission Body") # Replace with function body.
