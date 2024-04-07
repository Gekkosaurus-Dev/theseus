extends Area2D

@export var health_component: Node

@export var damage_from_player: bool
@export var damage_from_enemy: bool

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
		if (object_type.has("player") and damage_from_player):
			health_component.apply_damage(area.damage_amount)
		if (object_type.has("enemy") and damage_from_enemy):
			health_component.apply_damage(area.damage_amount)
