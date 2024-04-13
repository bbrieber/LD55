class_name WallRaycast extends Node2D

@onready var  wallRaycastLeft : RayCast2D = $RayCastLeft
@onready var  wallRaycastRigth : RayCast2D = $RayCastRight

func get_wall_dir() -> int:
	
	if wallRaycastLeft.is_colliding():
		return -1
	if wallRaycastRigth.is_colliding():
		return 1

	return 0
