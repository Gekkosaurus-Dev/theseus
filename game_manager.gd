extends Node2D

#region scene declarations
#region menu related
const main_menu_instance = preload("res://menus/main_menu.tscn")
const options_menu_instance = preload("res://menus/options.tscn")
const pause_screen_instance = preload("res://menus/pause.tscn")
#endregion

#region levels
const test_area_instance = preload("res://levels/top_down.tscn")
const area1_instance = preload("res://levels/area1.tscn")
const area2_instance = preload("res://levels/area2.tscn")
const area3_instance = preload("res://levels/area3.tscn")
const tutorial_instance = preload("res://levels/tutorial.tscn")
const boss_area_instance = preload("res://levels/boss_arena.tscn")
#const area1_instance = preload("res://levels/area1.tscn")
#const area2_instance = preload("res://levels/area2.tscn")
#const area3_instance = preload("res://levels/area3.tscn")
#endregion

#region other areas
const medic_report_instance = preload("res://menus/medic_report.tscn")
const map_instance = preload("res://menus/map_select.tscn")
#endregion

#region cutscenes
const intro_cutscene_instance = preload("res://cutscenes/intro_cutscene.tscn")
const another_cutscene_instance = preload("res://cutscenes/placeholders/another_cutscene.tscn")
#endregion

#region UI related
const fade_instance = preload("res://cutscenes/transition_fade.tscn")
const UI_instance = preload("res://menus/ui.tscn")
#endregion

#endregion

enum GameStates {MAIN_MENU, MENU, GAMEPLAY, NON_LEVEL_GAMEPLAY, CUTSCENE}
var game_state

enum GameInputs {CONTROLLER, KEYBOARD_MOUSE}
var game_input

#variables which are used throughout the game and need to be reset upon game reset
@export var max_days_left: int
@export var starting_soul_percent: float
@export var number_of_levels: int
@export var starting_gold: int
@export var starting_max_armour_health: int
var days_left
var soul_percent
var cybernetics_percentage_worth
var gold
var visited_areas: Array
var max_armour_health #could be altered over the course of the game if armour upgraded
var robot_head: bool

var UI: CanvasLayer
var current_game_scene: Node2D

var player_overall_health
var player_starting_health = 100

signal input_changed()

#resets all game values 
func clear_game_values():
	days_left = max_days_left
	soul_percent = starting_soul_percent
	cybernetics_percentage_worth = 100/number_of_levels
	gold = starting_gold
	max_armour_health = starting_max_armour_health
	visited_areas.clear()
	robot_head = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	clear_game_values()
	load_scene(main_menu_instance)	
	game_state = GameStates.MAIN_MENU
	#set default input as keyboard mouse
	game_input = GameInputs.KEYBOARD_MOUSE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	#handle pause
	if event.is_action_pressed("pause") and (game_state == GameStates.GAMEPLAY):
		pause_game()
	#detect input
	if (event is InputEventJoypadButton):
	#if ((event is InputEventJoypadButton) or (event is InputEventJoypadMotion)):
		if (game_input !=GameInputs.CONTROLLER):
			#print("controller detected")
			game_input = GameInputs.CONTROLLER
			input_changed.emit()
	elif (event is InputEventJoypadMotion) and (abs(event.axis_value) > 0.5):
		#print("axis = " + str(event.axis))
		if (game_input !=GameInputs.CONTROLLER):
			print("axis value = " + str(event.axis_value))
			#print("controller detected")
			game_input = GameInputs.CONTROLLER
			input_changed.emit()
	elif ((event is InputEventMouse) or (event is InputEventKey)):
		if (game_input !=GameInputs.KEYBOARD_MOUSE):
			#print("keyboard/mouse detected")
			game_input = GameInputs.KEYBOARD_MOUSE
			input_changed.emit()
	
func pause_game():
	#load_pause_screen()
	pass
	
#clears values and starts game from tutorial
func start_game(menu):
	clear_game_values()
	UI = load_scene(UI_instance)
	current_game_scene = await fade_to(menu,tutorial_instance,GameStates.GAMEPLAY)
	
	#fade_to(menu,tutorial_instance)
	
#loads the fade transition and waits for the screen to be black before loading the next bit
#also returns the scene incase we want to use it
func fade_to(from,to,state):
	#and then sets the current state to be a cutscene so you cant pause during the fade
	game_state = GameStates.CUTSCENE
	#loads the fade to black scene and then waits for the black to cover the screen before loading the next scene
	var fade = fade_instance.instantiate()	
	add_child(fade)
	await fade.screen_black
	from.queue_free()
	var new_scene = (load_scene(to))
	#sets the game state back to what we want it to be once the scene is loaded
	game_state = state
	return (new_scene)

#reusable code to load the scene we want
#also returns the scene incase we want to use it
func load_scene(scene_path):
	var scene = scene_path.instantiate()
	add_child(scene)
	return (scene)

func tutorial_finished(from):
	fade_to(from,another_cutscene_instance,GameStates.CUTSCENE)
	$UI.set_level_UI_visibility(false)
	robot_head = true


func load_medic_report(health,from):
	player_overall_health = health
	#var medic_report = medic_report_instance.instantiate()
	load_scene(medic_report_instance)
	game_state = GameStates.NON_LEVEL_GAMEPLAY
	from.queue_free()
	#fade_to(from, medic_report_instance,GameStates.NON_LEVEL_GAMEPLAY)
	#add_child(medic_report)
	$UI.set_level_UI_visibility(false)
	$Timer.stop()
	

func load_map_select(from):
	fade_to(from, map_instance, GameStates.NON_LEVEL_GAMEPLAY)
	$UI.set_day_counter_visibility(true)
	$UI.set_soul_visibility(true)
	$UI.update_day_counter()
	$UI.update_soul()
	 

func start_timer():
	$Timer.start()
	

func _on_timer_timeout():
	days_left = days_left - 1
	$UI.update_day_counter()
