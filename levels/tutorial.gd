extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_died():
	Engine.time_scale = 0.1
	$Timer.start()
	game_manager.tutorial_finished(self)

func _on_timer_timeout():
	Engine.time_scale = 1
	
	
