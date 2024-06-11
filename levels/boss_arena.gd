extends Node2D
var game_manager
func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func player_died():
	#Engine.time_scale = 0.1
	$Timer.start()

func boss_died():
	game_manager.load_scene(game_manager.end_cutscene_instance)
	
	queue_free()

func _on_timer_timeout():
	Engine.time_scale = 1
	game_manager.load_medic_report(0,self)

