extends Node2D

@onready var main_menu_instance = preload("res://levels/main_menu.tscn")
var test_area_instance = preload("res://levels/top_down.tscn")
var intro_cutscene_instance = preload("res://intro_cutscene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_game_values()
	load_intro_cutscene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func clear_game_values():
	pass
	
func start_game():
	clear_game_values()
	load_test_area()

func load_main_menu():
	var main_menu = main_menu_instance.instantiate()
	add_child(main_menu)
	
func load_test_area():
	var test_area = test_area_instance.instantiate()
	add_child(test_area)

func load_intro_cutscene():
	var test_area = test_area_instance.instantiate()
	add_child(test_area)
