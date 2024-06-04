extends Node2D

var game_manager
@export var player: CharacterBody2D

func get_game_manager():
	game_manager =  get_tree().root.get_child(1)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	var object_type = area.owner.get_groups()
	if (object_type.has("player")):
		var total_health = player.get_total_health()
		player.freeze()
		player.player_state = player.PlayerStates.END
		game_manager.visited_areas.append("Area 1")
		game_manager.load_medic_report(total_health,self)
		#print("AAAAAAAAAAA")
		#var damage_amount = player.get_damage_taken_amount(
		#queue_free()

func player_died():
	Engine.time_scale = 0.1
	$Timer.start()
	


func _on_timer_timeout():
	Engine.time_scale = 1
	game_manager.load_medic_report(0,self)
