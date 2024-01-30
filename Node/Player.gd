class_name Player extends CharacterBody2D

@onready var turret:Sprite2D = $TurretSprite
@onready var tankAnim:AnimatedSprite2D = $TankSprite
@onready var camera:Camera2D = $Camera2D
@onready var munSpawn:Marker2D = $TurretSprite/MunSpawnPoint
@export var id:int;

signal fire(pos:Vector2, angle:float)

const ROTATE_SPEED = PI/3
const TURRET_SPEED = PI/3
const SPEED = 8000

const RELOAD_TIME = 0.5
var reload = 0

var forward:bool
var backward:bool
var right:bool
var left:bool
var firing:bool

var mousePos:Vector2

func _ready():
	camera.enabled = multiplayer.get_unique_id() == id

func _input(event):
	if(multiplayer.get_unique_id() == id):
		var change:bool = false
		
		if(forward): 
			forward = !event.is_action_released("goForward")
			change = true
		else : 
			forward = event.is_action_pressed("goForward")
			change = true
			
		if(backward): 
			backward = !event.is_action_released("goBackward")
			change = true
		else : 
			backward = event.is_action_pressed("goBackward")
			change = true
			
		if(right): 
			right = !event.is_action_released("turnRight")
			change = true
		else : 
			right = event.is_action_pressed("turnRight")
			change = true
			
		if(left): 
			left = !event.is_action_released("turnLeft")
			change = true
		else : 
			left = event.is_action_pressed("turnLeft")
			change = true
		
		if(firing): 
			firing = !event.is_action_released("fire")
			change = true
		else : 
			firing = event.is_action_pressed("fire")
			change = true
		
		if(id != 1 && change):rpc_id(1,"syncMvm",forward,backward,right,left,firing)

@rpc("call_remote","any_peer")
func syncMvm(d0,d1,d2,d3,d4):
	self.forward = d0
	self.backward = d1
	self.right = d2
	self.left = d3
	self.firing = d4

@rpc("call_remote","any_peer")
func syncMousePos(mp):
	self.mousePos = mp

func _process(delta):
	if(multiplayer.get_unique_id() == id):
		mousePos = get_local_mouse_position()
		if(id != 1):rpc_id(1,"syncMousePos",mousePos)
	if(multiplayer.get_unique_id() == 1):
		if(right):rotate(ROTATE_SPEED*delta)
		if(left):rotate(-ROTATE_SPEED*delta)
		if(forward):velocity = Vector2(-sin(rotation),cos(rotation))*SPEED*delta
		elif(backward):velocity = Vector2(sin(rotation),-cos(rotation))*SPEED*delta
		else:velocity = Vector2.ZERO
		
		if(right or left or forward or backward):tankAnim.play()
		else:tankAnim.stop()
		
		var angleObjective = (atan2((mousePos.y),(mousePos.x)))-PI/2;
		var playerAngle = deg_to_rad(turret.rotation_degrees)
		var diff = angle_difference(playerAngle,angleObjective)
		if(abs(diff) > 0.1):
			playerAngle+=sign(diff)*TURRET_SPEED*delta
		turret.rotation_degrees = rad_to_deg(playerAngle)
		
		if(reload >= 0):reload-=delta;
		elif(firing):
			reload = RELOAD_TIME
			fire.emit(munSpawn.global_position, turret.rotation+self.rotation)
		
		move_and_slide()
