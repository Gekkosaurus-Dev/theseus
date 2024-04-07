extends CanvasLayer

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	$MarginContainer/HBoxContainer/VBoxContainer/Label2.text = ("You reached the end of the area and took damage " + str(game_manager.damage_taken_amount) + " times!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	game_manager.start_game()
	queue_free()
