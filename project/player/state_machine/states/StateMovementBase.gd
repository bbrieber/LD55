class_name StateMovementBase extends State



var gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")



#@export var run_time_to_peak : float = 0.1
##@export var run_time_to_stop : float = 0.1




@onready var run_acceleration : float = player.player_movement_config.run_velocity / player.player_movement_config.run_time_to_peak
@onready var run_deceleration : float = (-player.player_movement_config.run_velocity) / player.player_movement_config.run_time_to_stop
@onready var max_fall_speed : float = _get_gravity() * player.player_movement_config.time_to_max_fallspeed * -1

#var direction : Vector2 =  Vector2.ZERO


var target_velocity:Vector2 = Vector2.ZERO






	


func update_locomotion(direction: float, delta: float, update_view_dir:bool = true, freeze_x:bool = false, freeze_y:bool = false) -> void:
	
	if update_view_dir:
		player.player_skin.set_view_direction(direction)
		
	## Get linear velocity	
	if not freeze_x:
		if direction != 0:
			player.velocity.x = _get_run_velocity(direction,delta)
		else:
			player.velocity.x = 0
			#player.velocity.x =  _get_stop_velocity(direction,delta)#
			
			
	if not freeze_y:
		player.velocity.y -=  _get_gravity() * delta
		player.velocity.y = minf(player.velocity.y,max_fall_speed)
	
	player.move_and_slide()
	
	
func _get_gravity():
	return gravity 



	
func _get_stop_velocity(direction: float,delta:float) ->float:
	
	var target_dir_sign : int = 1 if direction > 0 else -1
	var current_dir_sign = 1 if player.velocity.x > 0 else -1

	
	var out = run_deceleration * delta *target_dir_sign
	if current_dir_sign > 1:
		out = min(out,0)
	else:
		out = max(out,0)
	return out


func _get_run_velocity(direction: float,delta:float) ->float:
	var out:float = player.velocity.x
	var target_dir_sign : int = 1 if direction > 0 else -1
	target_velocity.x = direction  * player.player_movement_config.run_velocity

	var accelerate : bool = true if ( 
		(target_dir_sign > 0 and target_velocity.x >= player.velocity.x) or
		(target_dir_sign < 0 and target_velocity.x <= player.velocity.x) 
		or
		(target_dir_sign > 0 and target_velocity.x < 0) or
		(target_dir_sign < 0 and target_velocity.x > 0)
		 ) else false
		
	if accelerate:
		out += run_acceleration * delta *target_dir_sign

	else:
		out += run_deceleration * delta *target_dir_sign
	
	if target_dir_sign > 0:
		out = max(out,target_velocity.x)
	else:
		out = min(out,target_velocity.x)
		

	return out
	
	

 
