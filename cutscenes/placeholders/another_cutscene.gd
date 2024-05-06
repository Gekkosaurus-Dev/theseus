extends CanvasLayer
var game_manager


func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	game_manager.load_map_select()
	queue_free()
