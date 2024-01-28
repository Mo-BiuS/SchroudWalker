extends Node

@onready var connectMenu:ConnectMenu = $ConnectMenu
@onready var schroudWalker:SchroudWalker = $SchroudWalker

const PORT:int = 9999
var enet_peer:ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func _on_connect_menu_create_client(ipAdress):
	enet_peer.create_client(ipAdress, PORT)
	multiplayer.multiplayer_peer = enet_peer
	await(multiplayer.connected_to_server)
	
	connectMenu.hide()
	schroudWalker.show()

func _on_connect_menu_create_server():
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.connect("peer_connected", serverAtPeerConnect)
	multiplayer.connect("peer_disconnected", serverAtPeerDisconnect)
	
	connectMenu.hide()
	schroudWalker.addPlayer(1)
	schroudWalker.showMenuServer()
	schroudWalker.show()

func serverAtPeerConnect(id:int):
	schroudWalker.addPlayer(id)
func serverAtPeerDisconnect(id:int):
	schroudWalker.removePlayer(id)
