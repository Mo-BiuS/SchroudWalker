class_name Arena extends TileMap

@onready var players:Node2D = $"../Players"
@onready var spawnCenter:Marker2D = $SpawnCenter
const SPAWN_DIST = 32

func getValidPlayerPos()->Vector2:
	var list:Array = spawnCenter.get_children()
	list.shuffle()
	
	var rep:Vector2 = list[0].position+spawnCenter.position
	while(!isValid(list[0].position+spawnCenter.position)):
		list.remove_at(0)
		rep = list[0].position+spawnCenter.position
	
	return rep

func isValid(pos:Vector2)->bool:
	for i in players.get_children():
		if(sqrt(pow(pos.x-i.position.x,2)+pow(pos.y-i.position.y,2)) < SPAWN_DIST):
			return false
	return true
