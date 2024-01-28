class_name Arena extends TileMap

func getValidPlayerPos()->Vector2:
	return get_children().pick_random().position*2
