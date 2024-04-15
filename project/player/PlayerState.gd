class_name PlayerState extends Node

@export var player: Player 
@onready var _coyote_timer = Timer.new()

var _on_ground  : bool = false
var _in_air  : bool = false
var _is_coyote_time : bool = false
var _jump_dir : int = false

var _wants_to_glide:bool = false
var _wants_to_climb:bool = false
var _wants_to_charge:bool = false


var _wants_to_fade:bool = false
var _is_fading:bool=false

var _is_dashing:bool=false
var _is_gliding:bool=false
#@onready var _jump_buffer_timer = Timer.new()


var fade_energy_timer : Timer=Timer.new()
var climb_energy_timer : Timer=Timer.new()
var glide_energy_timer : Timer=Timer.new()

func _ready() -> void:
	
	_coyote_timer.timeout.connect(__coyote_timer_over)
	_coyote_timer.wait_time = player.player_movement_config.jump_coyote_time
	_coyote_timer.one_shot = true
	add_child(_coyote_timer)
	
	climb_energy_timer.wait_time = 1
	climb_energy_timer.one_shot = false
	add_child(climb_energy_timer)
	
	glide_energy_timer.wait_time = 1
	glide_energy_timer.one_shot = false
	add_child(glide_energy_timer)
	
	
	fade_energy_timer.wait_time = 1
	fade_energy_timer.one_shot = false
	add_child(fade_energy_timer)

func _process(_delta:float):
	update()
		
func update():
	
	if not player.is_on_floor():		
		_in_air = true
		if _on_ground: 
			_on_ground = false 
			if player.velocity.y >= 0:				
				_start_coyote_time()
			#else:
				#print("no coyote")
#		velocity.y -=  _get_gravity() * delta
		if(player.velocity.y < 0):
			_jump_dir = -1
			
		else: #is Falling
			_jump_dir = 1		
			if can_glide() and not is_gliding():
				start_gliding()								
			if is_gliding() and not can_glide()  :
				stop_gliding()
	else:
		if is_gliding():
			stop_gliding()
		_on_ground = true
		_jump_dir = 0
		if _in_air and player.get_real_velocity().y > 0:
			#print("Land")
			_just_landed()



func _should_glide()-> bool:
	return _wants_to_glide
	
	
	
func can_glide()-> bool:
	return _should_glide() and  AlEnergySystem.get_current_energy() >= player.player_movement_config.glide_energy_per_second

func is_gliding()-> bool:
	return _is_gliding

func start_gliding():
	print("Start GLide")
	_is_gliding = true
	if glide_energy_timer.is_stopped():
		glide_energy_timer.timeout.connect(update_glide_energy)
		glide_energy_timer.start()
	
func can_fade_away()->bool:
	return _wants_to_fade and not _fade
	
func is_fade_active()->bool:
	return _fade_active

func stop_gliding():	
	print("Stop GLide")
	_is_gliding = false
	
	
func _start_coyote_time() -> void:
	#print("coyote_ started")
	_on_ground = false
	_is_coyote_time = true
	_coyote_timer.start()


func _just_landed() -> void:
	#print("just landed")
	#player_landed.emit()
	_in_air = false
	player.soundManager.play_land_sound()


func __coyote_timer_over() -> void:
	_is_coyote_time = false
	#print("coyote_ over")


var _is_dead = false

func kill_player() :
	_is_dead = true 

func trigger_respawn() :	
	player.respawn.emit()
	player.player_skin.respawn_player()
	player.player_skin.respawn_animation_finished.connect(respawn_finished)
	#await player.player_skin.anim_player.animation_finished
	
	#_is_dead = false 

func respawn_finished() :	
	player.player_skin.respawn_animation_finished.disconnect(respawn_finished)
	_is_dead = false 
	
	
func player_respawned() :
	_is_dead = true 

func is_dead() -> bool:
	return _is_dead
	
func is_movement_blocked() -> bool:
	return is_dead()
	

func can_jump() -> bool:
	return _on_ground or _is_coyote_time
	
func can_dash( ) -> bool:	
	return not is_movement_blocked() and AlEnergySystem.get_current_energy() >= player.player_movement_config.dash_energy
	
	
func start_dash( ) -> void :
	_is_dashing = true 
	
	
func stop_dash( ) -> void:
	_is_dashing = false
		
func is_dashing( ) -> bool:
	return _is_dashing

var _is_climbing = false 


func update_glide_energy():
	if not is_gliding():
		glide_energy_timer.stop()
		glide_energy_timer.timeout.disconnect(update_glide_energy)
		return
	AlEnergySystem.reduce_energy(player.player_movement_config.glide_energy_per_second)
	
	
	
#region climb

func update_climb_energy():
	if not is_climbing():
		climb_energy_timer.stop()
		climb_energy_timer.timeout.disconnect(update_climb_energy)
		return
	AlEnergySystem.reduce_energy(player.player_movement_config.climb_energy_per_second)
	
	
func start_climb( ) -> void :
	if climb_energy_timer.is_stopped():
		climb_energy_timer.timeout.connect(update_climb_energy)
		climb_energy_timer.start()
	_is_climbing = true 
	
func stop_climb( ) -> void:
	_is_climbing = false
		
func is_climbing( ) -> bool:
	return _is_climbing

func can_climb()->bool :
	return _wants_to_climb and player.is_on_wall() and AlEnergySystem.get_max_energy() >= player.player_movement_config.climb_energy_per_second

func _on_climb_event(wants_to_climb):
	print("wanna climb " , wants_to_climb )
	_wants_to_climb = wants_to_climb
#endregion climb


#region glide
func _on_glide_event(wants_to_glide):
	print("wanna glide " , wants_to_glide )
	
	_wants_to_glide = wants_to_glide

#endregion glide


#region charge

func _on_charge_event(wants_to_charge):
	_wants_to_charge = wants_to_charge

#endregion charge
	
#region fade
func _on_fade_event(wants_to_fade):
	if not _fade and wants_to_fade:
		_wants_to_fade = true		
	if _fade_active and wants_to_fade:
		stop_fading() 
	if not wants_to_fade:
		_wants_to_fade = false
	
	
	
func update_fade_energy():
	if not is_fading():
		fade_energy_timer.stop()
		fade_energy_timer.timeout.disconnect(update_fade_energy)
		
		return
	AlEnergySystem.reduce_energy(player.player_movement_config.fade_energy_per_second)
	if AlEnergySystem.get_current_energy() <player.player_movement_config.fade_energy_per_second:
		stop_fading()
	
	
var _fade = false	

func is_fading()-> bool:
	return _fade_active
	
func start_fading()-> void:
	_fade = true
	pass # Replace with function bod
	
	
func stop_fading()-> void:
	print("Fade Back")
	_fade = false
	_fade_active= false
	player.player_skin.fade_back()



var _fade_active :bool = false

func _on_fade_ready():
	print("fade ready")
	_fade_active = true
	if fade_energy_timer.is_stopped():
		fade_energy_timer.timeout.connect(update_fade_energy)
		fade_energy_timer.start()

#endregion fade
