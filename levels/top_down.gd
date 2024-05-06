extends Node2D

var game_manager
@export var player: CharacterBody2D

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	get_game_manager()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	var object_type = area.owner.get_groups()
	if (object_type.has("player")):
		#print("AAAAAAAAAAA")
		#var damage_amount = player.get_damage_taken_amount()
		
		#print("damadmad" + str(damage_amount))
		if !(player.armour_broken):
			game_manager.load_medic_report(200)
		else:
			game_manager.load_medic_report(player.player_health)
		queue_free()

func player_died():
	game_manager.load_medic_report(0)
	queue_free()
