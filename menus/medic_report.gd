extends Node2D

var game_manager

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()
	var damage_amount = game_manager.damage_taken_amount
	var report
	if ( damage_amount <= 0):
		report = "Your armour sustained some damage but you didn't take any hits yourself."
	elif (damage_amount < 5):
		report = "Your armour was damaged and you took a few hits. You should be fine to set out in the morning though."
	elif (damage_amount > 5):
		report = "Your armour broke and you have taken some major damage. We'll either need to replace the limb or it will take a few weeks to heal."
	elif (damage_amount > 10):
		report = "Your armour was destroyed and you've sustained some life-threatening damage. We need to operate immediately."
	$CanvasLayer/Label2.text = ("Medic's Report:\n" + report)
	#$CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Label2.text = ("You reached the end of the area and took damage " + str(game_manager.damage_taken_amount) + " times!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_temp_button_pressed():
	game_manager.load_map_select()
	queue_free()


func _on_mechanic_pressed():
	game_manager.soul_percent = game_manager.soul_percent - game_manager.cybernetics_percentage_worth
	game_manager.load_map_select()
	queue_free()

func _on_heal_pressed():
	game_manager.days_left = game_manager.days_left - 7
	game_manager.load_map_select()
	queue_free()
