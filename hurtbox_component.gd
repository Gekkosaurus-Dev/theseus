extends Area2D

@export var health_component: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):

	var box_type = area.get_groups()
	if (box_type.has("hitbox")):
		var object_type = area.owner.get_groups()
		if (object_type.has("player") or object_type.has("enemy")):
			#print(area.owner)
			health_component.apply_damage(area.damage_amount)
			#if !(object_type.has("enemy")):
				#print("why")
	#
	#
	#if !(box_type.has("hitbox") and area.get_parent().get_groups().has("enemy")):
		#print("HECK")
		#print (str(area.get_parent()) + " " + str(area.owner))
		#print(area.get_parent().get_groups())
	
