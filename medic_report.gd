extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	var damage_amount = game_manager.damage_taken_amount
	var report
	if ( damage_amount <= 0):
		report = "Your armour sustained some 
				\ndamage but you didn't take 
				\nany hits yourself."
	elif (damage_amount < 5):
		report = "Your armour was damaged and 
				\nyou took a few hits. You 
				\nshould be fine to set out 
				\nin the morning though."
	elif (damage_amount > 5):
		report = "Your armour broke and you 
				\nhave taken some major damage. 
				\nWe'll either need to replace 
				\nthe limb or it will take a 
				\nfew weeks to heal."
	elif (damage_amount > 10):
		report = "Your armour was destroyed 
				\nand you've sustained some 
				\nlife-threatening damage. 
				\nWe need to operate 
				\nimmediately."
	$CanvasLayer/Label2.text = ("Medic's Report:\n" + report)
	#$CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Label2.text = ("You reached the end of the area and took damage " + str(game_manager.damage_taken_amount) + " times!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_temp_button_pressed():
	game_manager.load_map_select()
	queue_free()
