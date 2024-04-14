class_name PlayerSkin extends Node2D


@onready var anim_player : AnimationPlayer = $SkinAnimationPlayer
@onready var sprite : Sprite2D = $SkinSprite
@export var player : Player 


signal respawn_animation_finished
signal fade_animation_finished

enum ANIMATION_STATE {
	IDLE,
	RUN,
	SPRINT,
	JUMP,
	FALL,
	CLIMB,
	TURN,
	WALL_SLIDE,
	DASH_FORWARD,
	DIE,
	RECHARGE
}

	
func start_charging():
	play_animation(PlayerSkin.ANIMATION_STATE.RECHARGE)
	var t =	$VFX/Center_Position/Recharge as CPUParticles2D
	t.emitting = true
	
	
func fade_away():
	#anim_player.play("Fade")
	var t =	$VFX/Center_Position/FadeAway as CPUParticles2D
	t.emitting = true
	
	var sprite = $SkinSprite as Sprite2D
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate:a", 0.25,0.5)
	player.set_collision_layer_value ( 6, false )
	#await anim_player.animation_finished
	fade_animation_finished.emit()
	
	
func fade_back():
	#anim_player.play_backwards("Fade")
	var sprite = $SkinSprite as Sprite2D
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate:a", 1,0.5)
	player.set_collision_layer_value ( 6, true )
	var t =	$VFX/Center_Position/FadeBack as CPUParticles2D
	t.emitting = true
	
func stop_charging():
	var t =	$VFX/Center_Position/Recharge as CPUParticles2D
	t.emitting = false

func play_animation(animation: ANIMATION_STATE):
	if animation == ANIMATION_STATE.IDLE:
		anim_player.play("Idle")
	elif animation == ANIMATION_STATE.RUN:
		anim_player.play("Run")
	elif animation == ANIMATION_STATE.TURN:
		anim_player.play("Turn")
	elif animation == ANIMATION_STATE.JUMP:
		anim_player.play("Jump")
	elif animation == ANIMATION_STATE.FALL:
		anim_player.play("Fall")
	elif animation == ANIMATION_STATE.WALL_SLIDE:
		anim_player.play("WallHold")
	elif animation == ANIMATION_STATE.CLIMB:
		anim_player.play("Climb")
	elif animation == ANIMATION_STATE.DASH_FORWARD:
		anim_player.play("DashForward")
	elif animation == ANIMATION_STATE.DIE:
		anim_player.play("Die")
	elif animation == ANIMATION_STATE.RECHARGE:
		anim_player.play("Charge")
		
	
	
@export var ghost_scene : PackedScene
@onready var _ghost_timer = Timer.new()

func start_dash():
	_ghost_timer.start()

func stop_dash():
	_ghost_timer.stop()
	
func _add_ghost() -> void:
	print("adding ")
	var ghost = ghost_scene.instantiate() as Ghost
	ghost.texture = sprite.texture
	ghost.position = sprite.global_position
	ghost.scale = sprite.global_scale
	ghost.hframes = sprite.hframes
	ghost.vframes = sprite.vframes
	ghost.frame = sprite.frame
	get_tree().current_scene.add_child(ghost)
	
func pause_animation() -> void:
	anim_player.pause()

var current_view_dir: float = 0
	
func set_view_direction(dir: float) -> void:
	if dir < 0:
		sprite.flip_h = true
	elif dir > 0:
		sprite.flip_h = false
		
	
func play_idle():
	anim_player.play(name)
	
func _ready():	
	_ghost_timer.timeout.connect(_add_ghost)
	_ghost_timer.wait_time = 0.05
	_ghost_timer.one_shot = false
	add_child(_ghost_timer)
	
	stop_charging()



func respawn_player():
	anim_player.play_backwards("Die")
	await anim_player.animation_finished
	respawn_animation_finished.emit()
	
		
