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
		#print(object_type)
		if (object_type.has("player") or object_type.has("enemy")):
			health_component.apply_damage(area.damage_amount)
