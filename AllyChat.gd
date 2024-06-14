extends CanvasLayer
var game_manager




func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_game_manager()
	Dialogic.start("communicate")
	Dialogic.signal_event.connect(on_dialogic_text_signal)

func on_dialogic_text_signal(argument:String):
	#declaring these signals differently incase i want to do soemtihng with them later
	if argument == "end_chat":
		game_manager.load_medic_report(game_manager.player_overall_health,self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
