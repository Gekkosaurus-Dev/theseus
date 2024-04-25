extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_1_pressed():
	if (game_manager.area1_visited == false):
		game_manager.load_area1()
		queue_free()

func _on_area_2_pressed():
	if (game_manager.area2_visited == false):
		game_manager.load_area2()
		queue_free()

func _on_area_3_pressed():
	if (game_manager.area3_visited == false):
		game_manager.load_area3()
		queue_free()
