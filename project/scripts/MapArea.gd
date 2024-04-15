class_name ScreenArea extends Area2D


@export var cam :Camera2D
@onready var collision :CollisionShape2D = $CollisionShape2D

func activate_area():
	pass

func _on_body_entered(body):
	if body is Player:
		var rect = collision.shape as RectangleShape2D
		var x = rect.size.x /2
		var y = rect.size.y /2
		var buffer  = 16
		cam.limit_left = collision.global_position.x - x - buffer
		cam.limit_right= collision.global_position.x + x + buffer
		cam.limit_top = collision.global_position.y - y - buffer
		cam.limit_bottom = collision.global_position.y +y + buffer
		return


func _on_body_exited(body):
	if body is Player:
		#body.set_cam_limits
		return
