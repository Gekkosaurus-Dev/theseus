extends Node2D

var game_manager

var cybernetics_percentage_worth_base
var cybernetics_percentage_worth_weighted

var rest_amount = 0

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)
	
func on_dialogic_text_signal(argument:String):
	#declaring these signals differently incase i want to do soemtihng with them later
	if argument == "no_action_needed":
		load_map_select()
	elif argument == "no_health_recovery":
		load_map_select()
	elif argument == "rest":
		load_map_select()
	elif argument == "cybernetics":
		load_map_select()
	elif argument == "died_no_action_needed":
		load_map_select()
	
func load_map_select():
	
	if (Dialogic.VAR.get('do_heal')):
		game_manager.player_starting_health = 100
	else:
		game_manager.player_starting_health = game_manager.player_overall_health
	
	game_manager.days_left -= Dialogic.VAR.get('rest_days')
	
	cybernetics_percentage_worth_weighted = cybernetics_percentage_worth_base * Dialogic.VAR.get('soul_worth_factor')
	game_manager.soul_percent -= cybernetics_percentage_worth_weighted
	
	game_manager.load_map_select(self)
	#queue_free()

func _ready():
	Dialogic.signal_event.connect(on_dialogic_text_signal)

	get_game_manager()
	print("game manager player health:" + str(game_manager.player_overall_health))
	print("diaglogic player health:" + str(Dialogic.VAR.player_health))
	Dialogic.VAR.set('player_health', game_manager.player_overall_health)
	#Dialogic.VAR.player_health = game_manager.player_overall_health
	print("diaglogic player health:" + str(Dialogic.VAR.player_health))
	Dialogic.start("medic_report")
	cybernetics_percentage_worth_base = game_manager.cybernetics_percentage_worth/5
	#var damage_amount = game_manager.damage_taken_amount
	#var report
	#if ( damage_amount > 100):
		#report = "Your armour sustained some damage but you didn't take any hits yourself."
		#cybernetics_percentage_worth_weighted = (cybernetics_percentage_worth_base*0)
	#elif (damage_amount > 70):
		#report = "Your armour was damaged and you took a few hits. You should be fine to set out in the morning though."
		#cybernetics_percentage_worth_weighted = (cybernetics_percentage_worth_base*0)
		#rest_amount = 1
	#elif (damage_amount >= 40):
		#report = "Your armour broke and you have taken some major damage. We'll either need to replace the limb or it will take a few weeks to heal."
		#cybernetics_percentage_worth_weighted = (cybernetics_percentage_worth_base*1)
		#rest_amount = 14
	#elif (damage_amount < 40):
		#report = "Your armour was destroyed and you've sustained some life-threatening damage. We need to operate immediately."
		#cybernetics_percentage_worth_weighted = (cybernetics_percentage_worth_base*2)
	#$CanvasLayer/Label2.text = ("Medic's Report:\n" + report)
	#$CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Label2.text = ("You reached the end of the area and took damage " + str(game_manager.damage_taken_amount) + " times!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_temp_button_pressed():
	game_manager.load_map_select()
	queue_free()


func _on_mechanic_pressed():
	game_manager.soul_percent = game_manager.soul_percent - cybernetics_percentage_worth_weighted
	game_manager.load_map_select()
	queue_free()

func _on_heal_pressed():
	game_manager.days_left = game_manager.days_left - rest_amount
	game_manager.load_map_select()
	queue_free()
