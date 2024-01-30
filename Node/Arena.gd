class_name Arena extends TileMap

@onready var playerList:Node2D = $"../PlayerList"
@onready var spawnCenter:Marker2D = $SpawnCenter
@onready var spawnList:Node2D = $SpawnList
const SPAWN_DIST = 32

func getValidPlayerPos()->Vector2:
	var list:Array = spawnList.get_children()
	list.shuffle()
	
	var rep:Vector2 = list[0].position
	while(!isValid(list[0].position)):
		list.remove_at(0)
		rep = list[0].position
	
	return rep

func isValid(pos:Vector2)->bool:
	for i in playerList.get_children():
		if(sqrt(pow(pos.x-i.position.x,2)+pow(pos.y-i.position.y,2)) < SPAWN_DIST):
			return false
	return true
