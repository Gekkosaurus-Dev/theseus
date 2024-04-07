extends Node2D

@onready var main_menu_instance = preload("res://levels/main_menu.tscn")
var options_menu_instance = preload("res://levels/options.tscn")
var test_area_instance = preload("res://levels/top_down.tscn")
var intro_cutscene_instance = preload("res://intro_cutscene.tscn")
var pause_screen_instance = preload("res://levels/pause.tscn")
var medic_report_instance = preload("res://medic_report.tscn")

var damage_taken_amount

enum GameStates {MAIN_MENU, MENU, GAMEPLAY}
var game_state

enum GameInputs {CONTROLLER, KEYBOARD_MOUSE}
var game_input

#change_scene_to_file()

# Called when the node enters the scene tree for the first time.
func _ready():
	#set default input as keyboard mouse
	game_input = GameInputs.KEYBOARD_MOUSE
	
	clear_game_values()
	load_main_menu()

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
	pass
	
func start_game():
	clear_game_values()
	load_test_area()
	#load_intro_cutscene()

func load_main_menu():
	var main_menu = main_menu_instance.instantiate()
	add_child(main_menu)
	game_state = GameStates.MAIN_MENU
	
func load_test_area():
	var test_area = test_area_instance.instantiate()
	add_child(test_area)
	game_state = GameStates.GAMEPLAY

func load_intro_cutscene():
	var intro_cutscene = intro_cutscene_instance.instantiate()
	add_child(intro_cutscene)
	game_state = GameStates.GAMEPLAY
	
func load_options_menu():
	var options_menu = options_menu_instance.instantiate()
	add_child(options_menu)

func load_pause_screen():
	var pause_screen = pause_screen_instance.instantiate()
	add_child(pause_screen)

func load_medic_report(damage_amount):
	damage_taken_amount = damage_amount
	var medic_report = medic_report_instance.instantiate()
	add_child(medic_report)
	
