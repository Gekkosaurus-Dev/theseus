extends CanvasLayer
var game_manager
const skip_overlay = preload("res://menus/skip_overlay.tscn")


func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()
	Dialogic.start("intro_cutscene")
	Dialogic.signal_event.connect(on_dialogic_text_signal)
	
	var scene = skip_overlay.instantiate()
	add_child(scene)

	
func skip_button_pressed():
	#print("pressed skip")
	get_tree().root.get_child(2).queue_free() #kill the dialogic scene early
	#dialogic_scene.queue_free()
	game_manager.load_map_select(self)

func on_dialogic_text_signal(argument:String):
	#declaring these signals differently incase i want to do soemtihng with them later
	if argument == "intro_cutscene_end":
		game_manager.load_map_select(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	game_manager.load_map_select(self)
	#queue_free()
