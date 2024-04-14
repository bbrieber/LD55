extends Area2D




func _on_body_entered(body):
	if body is Player:
		body.on_hit()
	else:
		print("Unexspected collission Body") # Replace with function body.
