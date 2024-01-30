class_name Munition extends Sprite2D

const SPEED = 600
const DMG = 2

func _physics_process(delta):
	if(multiplayer.get_unique_id() == 1):
		position += Vector2(-sin(rotation),cos(rotation))*SPEED*delta
		


func _on_area_2d_body_entered(body):
	if(body is Player):
		body.getDamage(DMG)
	queue_free()
