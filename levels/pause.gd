extends CanvasLayer

@onready var options_menu_instance = preload("res://levels/options.tscn")

var game_manager
func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_resume_pressed():
	#UNPAUSE THE GAME
	queue_free()
	pass # Replace with function body.

func _on_option_pressed():
	load_options_menu()

func _on_main_menu_pressed():
	pass # Replace with function body.

func load_options_menu():
	var options_menu = options_menu_instance.instantiate()
	add_child(options_menu)
