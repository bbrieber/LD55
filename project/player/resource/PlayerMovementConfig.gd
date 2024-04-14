class_name PlayerMovementConfig extends Resource


@export_category("Run")
@export var run_time_to_peak : float = 0.2
@export var run_time_to_stop : float = 0.2
@export var run_velocity: float = 128


@export_category("Jump")
@export var jump_height : float = 40
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descend : float = 0.35
@export var glide_time_to_descend : float = 1
@export var jump_stop_factor : float = 2
@export var jump_coyote_time : float = 0.2
@export var time_to_max_fallspeed : float = .3


@export_category("Wall")
@export var slide_time_to_descend : float = 0.6

@export var dash_distance : float = 64
@export var dash_time_to_peak : float = 0.4
@export var dash_stop_factor : float = 4


@export var climb_velocity: float = 128
@export var climb_time_to_peak : float = 0.6


@export_category("Energy")
@export var climb_energy_per_second: float = 0.5
@export var glide_energy_per_second: float = 0.5
@export var dash_energy: float = 5
@export var recover_energy_per_second: float = 2


