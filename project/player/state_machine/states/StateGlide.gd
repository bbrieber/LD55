class_name State_Fall extends StateMovementBase






@onready var fall_gravity : float = (-2* player.player_movement_config.jump_height) / (player.player_movement_config.glide_time_to_descend *player.player_movement_config.glide_time_to_descend)

func enter(_msg := {}) -> void:
	player.player_skin.play_animation(PlayerSkin.ANIMATION_STATE.FALL)
	#print("FALL")
func exit() -> void:
	pass
	#print("stop FALL")




func physics_update(ownerBody: CharacterBody2D,delta: float) -> void:
	var direction = player.input_processor.direction
	update_locomotion(direction.x,delta)





func _get_gravity() -> float:
	return fall_gravity

			
