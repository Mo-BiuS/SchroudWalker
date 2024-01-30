class_name SchroudWalker extends Node2D

@onready var menuServer:MenuServer = $MenuServer;
@onready var arena:Arena = $Arena
@onready var playerList:Node2D = $PlayerList
@onready var munitionList:Node2D = $MunitionList

var playerClass:PackedScene = preload("res://Node/Player.tscn")
var munitionClass:PackedScene = preload("res://Node/Munition.tscn")

func addPlayer(id:int):
	var player:Player = playerClass.instantiate()
	player.id = id;
	player.position = arena.getValidPlayerPos()
	player.rotation_degrees = rad_to_deg(atan2(arena.spawnCenter.position.y-player.position.y, arena.spawnCenter.position.x-player.position.x)-PI/2)
	player.connect("fire",addMunition)
	playerList.add_child(player,true)

func removePlayer(id:int):
	pass

func addMunition(pos:Vector2, angle:float):
	var mun:Munition = munitionClass.instantiate()
	mun.global_position = pos/2;
	mun.rotation = angle
	munitionList.add_child(mun,true)

func showMenuServer():
	menuServer.show()
