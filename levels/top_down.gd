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
		var damage_amount = player.get_damage_taken_amount()
		#print("damadmad" + str(damage_amount))
		game_manager.load_medic_report(damage_amount)
		queue_free()

