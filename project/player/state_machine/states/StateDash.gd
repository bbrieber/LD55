class_name State_Dash extends StateMovementBase



@onready var _dash_timer:Timer = Timer.new()
@export var dash_duration:float = 0.2



@export var jump_head_cast_left: JumpHeadCast
@export var jump_head_cast_right : JumpHeadCast



@onready var dash_velocity : float = (2*player.player_movement_config.dash_distance) / player.player_movement_config.dash_time_to_peak
@onready var dash_gravity : float = (-2*player.player_movement_config.dash_distance) / (player.player_movement_config.dash_time_to_peak *player.player_movement_config.dash_time_to_peak)

var jump_factor :float = 1


var main_dir:Vector2

func enter(_msg := {}) -> void:
	#player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.JUMP)
	main_dir = player.input_processor.main_direction.normalized()
	if main_dir.x == 0 and main_dir.y ==0:
		main_dir.x = player.player_skin.current_view_dir
	AlEnergySystem.reduce_energy(player.player_movement_config.dash_energy)
	print("start dashing" )
	_dash_timer.timeout.connect(__dash_timer_over)
	_dash_timer.wait_time = dash_duration
	_dash_timer.one_shot = true
	add_child(_dash_timer)
	_dash_timer.start()
	
	player.player_state.start_dash()
	#print("JUMP")
	jump_factor = 1
	player.velocity = main_dir * dash_velocity
	player.player_skin.start_dash()
	
func exit() -> void:
	remove_child(_dash_timer)
	_dash_timer.timeout.disconnect(__dash_timer_over)
	pass
	#print("stop JUMP")


func __dash_timer_over()->void:
	player.player_state.stop_dash()
	player.player_skin.stop_dash()
	jump_factor = player.player_movement_config.dash_stop_factor
	
	print("stop dashing")
	
func physics_update(_ownerBody: CharacterBody2D,delta: float) -> void:
	#var direction = input_processor.direction
	
	#player.velocity = main_dir * dash_velocity
	
	update_locomotion(main_dir.x,delta,true,true,player.player_state.is_dashing())





func _get_gravity() -> float:
	return dash_gravity * jump_factor

			
