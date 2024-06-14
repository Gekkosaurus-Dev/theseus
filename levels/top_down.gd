extends Node2D

var game_manager
@export var enemies_group: Node2D
@export var player: CharacterBody2D

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func count_enemies():
	var enemies_array = enemies_group.get_children()
	var num_enemies = enemies_array.size()
	#print(num_enemies)
	return num_enemies

func _on_area_2d_area_entered(area):
	var object_type = area.owner.get_groups()
	if (object_type.has("player")) and (count_enemies() <=0):
		var total_health = player.get_total_health()
		player.freeze()
		player.player_state = player.PlayerStates.END
		if !(game_manager.visited_areas.has("Area 1")):
			#game_manager.load_ally_chat(total_health)
			game_manager.visited_areas.append("Area 1")
			Dialogic.VAR.set('soul_percent', game_manager.soul_percent)
			#print (game_manager.visited_areas)
			game_manager.load_medic_report(total_health,self)
		elif !(game_manager.visited_areas.has("Area 2")):
			game_manager.visited_areas.append("Area 2")
			Dialogic.VAR.set('soul_percent', game_manager.soul_percent)
			#print (game_manager.visited_areas)
			game_manager.load_medic_report(total_health,self)
		elif !(game_manager.visited_areas.has("Area 3")):
			game_manager.visited_areas.append("Area 3")
			Dialogic.VAR.set('soul_percent', game_manager.soul_percent)
			game_manager.load_ally_chat(total_health)
			queue_free()
			#print (game_manager.visited_areas)
			
		
		#print("AAAAAAAAAAA")
		#var damage_amount = player.get_damage_taken_amount(
		#queue_free()

func player_died():
	Engine.time_scale = 0.1
	$Timer.start()
	


func _on_timer_timeout():
	Engine.time_scale = 1
	game_manager.load_medic_report(0,self)
