class_name Player extends CharacterBody2D

@onready var tankAnim:AnimatedSprite2D = $TankSprite
@export var id:int;

const ROTATE_SPEED = 0.02
const TURRET_SPEED = 0.04
const SPEED = 100

var forward:bool
var backward:bool
var right:bool
var left:bool;

func _input(event):
	if(multiplayer.get_unique_id() == id):
		if(forward): forward = !event.is_action_released("goForward")
		else : forward = event.is_action_pressed("goForward")
		
		if(backward): backward = !event.is_action_released("goBackward")
		else : backward = event.is_action_pressed("goBackward")
		
		if(right): right = !event.is_action_released("turnRight")
		else : right = event.is_action_pressed("turnRight")
		
		if(left): left = !event.is_action_released("turnLeft")
		else : left = event.is_action_pressed("turnLeft")
		
		if(id != 1):rpc_id(1,"syncMvm",forward,backward,right,left)

@rpc("call_remote","any_peer")
func syncMvm(d0,d1,d2,d3):
	self.forward = d0
	self.backward = d1
	self.right = d2
	self.left = d3

func _process(delta):
	if(multiplayer.get_unique_id() == 1):
		if(right):rotate(ROTATE_SPEED)
		if(left):rotate(-ROTATE_SPEED)
		if(forward):velocity = Vector2(-sin(rotation)*SPEED,cos(rotation)*SPEED)
		elif(backward):velocity = Vector2(sin(rotation)*SPEED,-cos(rotation)*SPEED)
		else:velocity = Vector2.ZERO
		
		if(right or left or forward or backward):tankAnim.play()
		else:tankAnim.stop()
		
		move_and_slide()
