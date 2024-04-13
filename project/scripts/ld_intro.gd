extends Node


@onready var timer:Timer = Timer.new()
@export var scene:PackedScene
@export var wait_time:float = 2

# Called when the node enters the scene tree for the first time.
func _ready():	
	timer.timeout.connect(_switch_scene)
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _switch_scene():
	get_tree().change_scene_to_packed(scene)
