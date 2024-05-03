extends Node2D

var main_menu_instance = preload("res://menus/main_menu.tscn")
var options_menu_instance = preload("res://menus/options.tscn")
var test_area_instance = preload("res://levels/top_down.tscn")
var intro_cutscene_instance = preload("res://cutscenes/intro_cutscene.tscn")
var pause_screen_instance = preload("res://menus/pause.tscn")
var medic_report_instance = preload("res://menus/medic_report.tscn")
var another_cutscene_instance = preload("res://cutscenes/placeholders/another_cutscene.tscn")

var map_instance = preload("res://menus/map_select.tscn")

var area1_instance = preload("res://levels/area1.tscn")
var area2_instance = preload("res://levels/area2.tscn")
var area3_instance = preload("res://levels/area3.tscn")

var tutorial_instance = preload("res://levels/tutorial.tscn")

var fade_instance = preload("res://cutscenes/transition_fade.tscn")

var damage_taken_amount

enum GameStates {MAIN_MENU, MENU, GAMEPLAY, CUTSCENE}
var game_state

enum GameInputs {CONTROLLER, KEYBOARD_MOUSE}
var game_input

var area1_visited = false
var area2_visited = false
var area3_visited = false
#change_scene_to_file()

var max_days_left = 70
var days_left
var number_of_levels = 3
var cybernetics_percentage_worth
var soul_percent = 90 #starts at a small amount lost becasue of the robot face

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_game_values()
	load_scene(main_menu_instance)	
	game_state = GameStates.MAIN_MENU
	#set default input as keyboard mouse
	game_input = GameInputs.KEYBOARD_MOUSE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("pause") and (game_state == GameStates.GAMEPLAY)):
		#load_pause_screen()
		pass
	else:
		pass

func _input(event):
	if (event is InputEventJoypadButton):
	#if ((event is InputEventJoypadButton) or (event is InputEventJoypadMotion)):
		if (game_input !=GameInputs.CONTROLLER):
			print("controller detected")
			game_input = GameInputs.CONTROLLER
	elif ((event is InputEventMouse) or (event is InputEventKey)):
		if (game_input !=GameInputs.KEYBOARD_MOUSE):
			print("keyboard/mouse detected")
			game_input = GameInputs.KEYBOARD_MOUSE

func clear_game_values():
	days_left = max_days_left
	cybernetics_percentage_worth = 100/number_of_levels
	
#clears values and starts game from tutorial
func start_game(menu):
	clear_game_values()
	fade_to(menu,tutorial_instance)
	game_state = GameStates.GAMEPLAY

#loads the fade transition and waits for the screen to be black before loading the next bit
func fade_to(from,to):
	#saves the game state that we want the game to be after the fade
	#and then sets the current state to be a cutscene so you cant pause during the fade
	var cur_game_state = game_state
	game_state = GameStates.CUTSCENE
	#loads the fade to black scene and then waits for the black to cover the screen before loading the next scene
	var fade = fade_instance.instantiate()	
	add_child(fade)
	await fade.screen_black
	from.queue_free()
	load_scene(to)
	#sets the game state back to what we want it to be once the scene is loaded
	game_state = cur_game_state

#reusable code to load the scene we want
func load_scene(scene):
	var scene_instance = scene.instantiate()
	add_child(scene_instance)

func load_medic_report(damage_amount):
	damage_taken_amount = damage_amount
	var medic_report = medic_report_instance.instantiate()
	add_child(medic_report)
	$UI.set_level_UI_visibility(false)

func load_map_select():
	var map = map_instance.instantiate()
	add_child(map)
	game_state = GameStates.GAMEPLAY
	$UI.set_day_counter_visibility(true)
	$UI.set_soul_visibility(true)
	$UI.update_day_counter()
	$UI.update_soul()
