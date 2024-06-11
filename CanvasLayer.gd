extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()
	Dialogic.VAR.set('soul_percent', game_manager.soul_percent)
	Dialogic.start("end_cutscene")
	Dialogic.signal_event.connect(on_dialogic_text_signal)

func on_dialogic_text_signal(argument:String):
	#declaring these signals differently incase i want to do soemtihng with them later
	if argument == "ENDGAME":
		game_manager.end_game()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
