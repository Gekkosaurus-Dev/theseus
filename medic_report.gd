extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	#$CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Label2.text = ("You reached the end of the area and took damage " + str(game_manager.damage_taken_amount) + " times!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_temp_button_pressed():
	game_manager.load_map_select()
	queue_free()
