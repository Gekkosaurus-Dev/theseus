extends Node2D

var game_manager

@export var area1_button: Button
@export var area2_button: Button
@export var area3_button: Button

@export var linet1: TextureRect
@export var line12: TextureRect
@export var line23: TextureRect

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	area1_button.visible = true
	linet1.visible = true
	area2_button.visible = false
	area3_button.visible = false
	line12.visible = false
	line23.visible = false
	get_game_manager()
	if game_manager.visited_areas.has("Area 1"):
		area1_button.disabled = true
		area2_button.visible = true
		line12.visible = true
	elif game_manager.visited_areas.has("Area 2"):
		area2_button.disabled = true
		area3_button.visible = true	
		line23.visible = true
	elif game_manager.visited_areas.has("Area 3"):
		area3_button.disabled = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_1_pressed():
	#if (game_manager.area1_visited == false):
	game_manager.load_scene(game_manager.area1_instance)
	
	game_manager.start_timer()
	queue_free()

func _on_area_2_pressed():
	#if (game_manager.area2_visited == false):
	game_manager.load_scene(game_manager.area2_instance)
	game_manager.start_timer()
	queue_free()

func _on_area_3_pressed():
	#if (game_manager.area3_visited == false):
	game_manager.load_scene(game_manager.area3_instance)
	game_manager.start_timer()
	queue_free()


func _on_area_1_button_pressed():
	game_manager.load_scene(game_manager.area1_instance)
	
	game_manager.start_timer()
	queue_free()


func _on_area_2_button_pressed():
	pass # Replace with function body.


func _on_area_3_button_pressed():
	pass # Replace with function body.
