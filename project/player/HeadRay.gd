extends Node2D

class_name JumpHeadCast


@onready var  cornerRaycast : RayCast2D = $RayCastCorner
@onready var  bufferRaycast : RayCast2D = $RayCastCorner/RayCastBuffer

@export var ray_length = 4
@export var ray_offset = 2

 
func _ready() -> void:
	cornerRaycast.target_position.y = -1 * ray_length
	cornerRaycast.target_position.x = 0
	bufferRaycast.target_position.y = -1 * ray_length
	bufferRaycast.target_position.x = 0
	
	bufferRaycast.position.x=ray_offset
	bufferRaycast.position.y=0
	
func get_jump_shift() -> int:
	if not cornerRaycast.is_colliding():
		#print("not colliding")
		return 0
	if bufferRaycast.is_colliding():
		#print("both_colliding")
		return 0
	#print("shift")
	return ray_offset
