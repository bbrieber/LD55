class_name PlayerState extends Node

@export var player: Player 
@onready var _coyote_timer = Timer.new()

var _on_ground  : bool = false
var _in_air  : bool = false
var _is_coyote_time : bool = false
var _jump_dir : int = false

var _wants_to_glide = false
var _wants_to_climb = false

var _is_dashing:bool=true
var _is_gliding:bool=true
#@onready var _jump_buffer_timer = Timer.new()

func _should_glide()-> bool:
	return _wants_to_glide

func is_gliding()-> bool:
	return _is_gliding

func _process(_delta:float):
	update(player)

func update(player : Player):
	
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
			_is_gliding = _should_glide()
	else:
		
		_is_gliding = false
		_on_ground = true
		_jump_dir = 0
		if _in_air and player.get_real_velocity().y > 0:
			#print("Land")
			_just_landed()

func _ready() -> void:
	
	_coyote_timer.timeout.connect(__coyote_timer_over)
	_coyote_timer.wait_time = player.player_movement_config.jump_coyote_time
	_coyote_timer.one_shot = true
	add_child(_coyote_timer)

func _start_coyote_time() -> void:
	#print("coyote_ started")
	_on_ground = false
	_is_coyote_time = true
	_coyote_timer.start()


func _just_landed() -> void:
	#print("just landed")
	#player_landed.emit()
	_in_air = false


func __coyote_timer_over() -> void:
	_is_coyote_time = false
	#print("coyote_ over")



func can_jump() -> bool:
	return _on_ground or _is_coyote_time
	
func can_dash( ) -> bool:
	return true
	
	
func start_dash( ) -> void :
	_is_dashing = true 
	
	
func stop_dash( ) -> void:
	_is_dashing = false
		
func is_dashing( ) -> bool:
	return _is_dashing

var _is_climbing = false 

func start_climb( ) -> void :
	_is_climbing = true 
	
	
func stop_climb( ) -> void:
	_is_climbing = false
		
func is_climbing( ) -> bool:
	return _is_climbing

func can_climb()->bool :
	return _wants_to_climb and player.is_on_wall()



func _on_glide_event(wants_to_glide):
	print("wanna glide " , wants_to_glide )
	
	_wants_to_glide = wants_to_glide


func _on_climb_event(wants_to_climb):
	print("wanna climb " , wants_to_climb )
	_wants_to_climb = wants_to_climb
