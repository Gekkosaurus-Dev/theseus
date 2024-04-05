extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

func _on_play_pressed():
	print("a")
	$"..".start_game()
	queue_free()

func _on_options_pressed():
	game_manager.load_options_menu()

func _on_quit_pressed():
	get_tree().quit()
