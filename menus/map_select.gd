extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_1_pressed():
	if (game_manager.area1_visited == false):
		game_manager.load_scene(game_manager.area1_instance)
		
		game_manager.start_timer()
		queue_free()

func _on_area_2_pressed():
	if (game_manager.area2_visited == false):
		game_manager.load_scene(game_manager.area2_instance)
		queue_free()

func _on_area_3_pressed():
	if (game_manager.area3_visited == false):
		game_manager.load_scene(game_manager.area3_instance)
		queue_free()
