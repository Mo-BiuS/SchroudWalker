class_name Munition extends CharacterBody2D

const SPEED = 600

func _physics_process(delta):
	if(multiplayer.get_unique_id() == 1):
		velocity = Vector2(-sin(rotation),cos(rotation))*SPEED*delta
		var collided = move_and_collide(velocity)
		if collided != null:
			queue_free()
