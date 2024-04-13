class_name Ghost extends Sprite2D

func _ready():
	ghost()

func set_props(m_position:Vector2,m_scale : Vector2) -> void :
	position = m_position
	scale = m_scale
	

	
	

func ghost() -> void :
	var ghost_tween = get_tree().create_tween()
	ghost_tween.tween_property(self,"self_modulate",Color(1,1,1,0),0.75)
	await ghost_tween.finished
	queue_free()
