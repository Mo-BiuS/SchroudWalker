class_name SchroudWalker extends Node2D

@onready var menuServer:MenuServer = $MenuServer;
@onready var arena:Arena = $Arena
@onready var players:Node2D = $Players
@onready var munitions:Node2D = $Munitions

var playerClass:PackedScene = preload("res://Node/Player.tscn")

func addPlayer(id:int):
	var player:Player = playerClass.instantiate()
	player.id = id;
	player.position = arena.getValidPlayerPos()
	player.rotation_degrees = rad_to_deg(atan2(arena.spawnCenter.position.y-player.position.y, arena.spawnCenter.position.x-player.position.x))
	players.add_child(player,true)

func removePlayer(id:int):
	pass

func showMenuServer():
	menuServer.show()

