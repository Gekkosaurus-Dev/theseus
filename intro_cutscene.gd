extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	$AnimationPlayer.play("cutscene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_pressed():
	load_next()

func _on_animation_player_animation_finished(anim_name):
	load_next()

func load_next():
	game_manager.load_test_area()
	queue_free()
