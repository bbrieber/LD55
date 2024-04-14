extends State



@onready var _respawn_timer:Timer = Timer.new()
@export var _respawn_duration:float = 1


func _ready():
	_respawn_timer.wait_time = _respawn_duration
	_respawn_timer.one_shot = true
	add_child(_respawn_timer)
	
func enter(_msg := {}) -> void:
	print("Player Died")
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.DIE)
	
	_respawn_timer.timeout.connect(player.player_state.trigger_respawn)
	_respawn_timer.start()
	
	
func __respawn_timer_over() -> void:
	player.player_state.player_respawned()

	
func exit() -> void:
	AlEnergySystem.restore_energy()
	_respawn_timer.timeout.disconnect(player.player_state.trigger_respawn)
	
	pass


