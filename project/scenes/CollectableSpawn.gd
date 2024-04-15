@tool
extends Marker2D

@export var collectable_scene : PackedScene
var collectable: EnergyBall

func activate_collectable()->void:
	if not collectable: 
		collectable = collectable_scene.instantiate() as EnergyBall
		add_child(collectable)

# Called when the node enters the scene tree for the first time.
func _ready():
	activate_collectable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_spawn_point_on_respawn():
	pass # Replace with function body.
