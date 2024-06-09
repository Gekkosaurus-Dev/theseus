extends Area2D

@export var health_component: Node

@export var damage_from_player: bool
@export var damage_from_enemy: bool

#var damage_number = preload("res://menus/damage_number.tscn")

#@export var damage_number_pos: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	var box_type = area.get_groups()
	if (box_type.has("hitbox")):
		var object_type = area.owner.get_groups()
		#print(object_type)
		if (object_type.has("player") and damage_from_player):
			#print("hit")
			call_hit(area.damage_amount)
		if (object_type.has("enemy") and damage_from_enemy):
			#print("hit")
			call_hit(area.damage_amount)

func call_hit(damage_amount):
	health_component.apply_damage(damage_amount)
	
	#var damage_number_instance = damage_number.instantiate()
	#add_child(damage_number_instance)
	#damage_number_instance.set_up(damage_number_pos.position.x,damage_number_pos.position.y,damage_amount)
