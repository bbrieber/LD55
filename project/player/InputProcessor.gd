class_name InputProcessor extends Node


var should_start_jump: bool
var should_stop_jump: bool

var should_start_climb: bool
var should_stop_climb: bool

var should_start_glide: bool = false
var should_stop_glide: bool = false

var wanna_glide : bool = false
var wanna_climb : bool = false
var wanna_charge : bool = false
var wanna_fade : bool = false


var should_start_fade: bool
var should_stop_fade: bool

var should_start_dash: bool

var direction: Vector2
var horizontal_dir : float
var vertical_dir : float
var main_direction: Vector2

signal glide_event(wants_to_glide:bool)
signal climb_event(wants_to_climb:bool)
signal charge_event(wants_to_charge:bool)
signal fade_event(wants_to_fade:bool)


func _physics_process (_delta : float ) -> void:
	
	should_start_glide = Input.is_action_just_pressed("fly")
	should_stop_glide = Input.is_action_just_released("fly") 
	var _wanna_glide = Input.is_action_pressed("fly") 
	if wanna_glide != _wanna_glide:
		glide_event.emit(_wanna_glide)	
		wanna_glide = _wanna_glide

	var _wanna_charge = Input.is_action_pressed("charge") 
	if wanna_charge != _wanna_charge:
		charge_event.emit(_wanna_charge)	
		wanna_charge = _wanna_charge
		
		
	should_start_jump = Input.is_action_just_pressed("jump")	
	should_stop_jump = Input.is_action_just_released("jump") 
	
	should_start_dash = Input.is_action_just_pressed("dash")	

	
	var _wanna_climb = Input.is_action_pressed("climb") 
	if wanna_climb != _wanna_climb:
		climb_event.emit(_wanna_climb)	
		wanna_climb = _wanna_climb
		
		
	var _wanna_fade = Input.is_action_pressed("fade") 
	if wanna_fade != _wanna_fade:
		fade_event.emit(_wanna_fade)	
		wanna_fade = _wanna_fade
	
		
	#should_start_climb = Input.is_action_just_pressed("climb") 	
	#should_stop_climb = Input.is_action_just_released("climb") 
	#
	#should_start_fade = Input.is_action_just_pressed("fade") 	
	#should_stop_fade = Input.is_action_just_released("fade") 
	
	horizontal_dir = Input.get_axis("move_left","move_right")
	vertical_dir = Input.get_axis( "move_up","move_down")
	
	direction = Input.get_vector("move_left", "move_right", "move_down","move_up")
	var dir_normalized = direction.normalized()
	main_direction = Vector2(0,0)
	if dir_normalized.x > 0.5:
		main_direction.x = 1
	elif dir_normalized.x < - 0.5:
		main_direction.x = -1
		
		
	if dir_normalized.y > 0.5:
		main_direction.y = -1
	elif dir_normalized.y < - 0.5:
		main_direction.y = 1
