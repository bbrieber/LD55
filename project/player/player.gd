class_name Player extends CharacterBody2D


@export var player_movement_config : PlayerMovementConfig
@export var initial_energy : Energy
@export var player_skin: PlayerSkin
@export var soundManager: PlayerSoundManager

@export var input_processor: InputProcessor
@export var player_state: PlayerState


signal respawn


func _ready():
	AlEnergySystem.initialize(initial_energy)

func on_hit():
	player_state.kill_player()

