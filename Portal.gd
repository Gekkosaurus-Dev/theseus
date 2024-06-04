extends StaticBody2D

@export var health_component: Node
@export var spawn_area: Polygon2D
@export var spawn_enemies: bool
#max amount of enemies that can be spawned at once by this portal
@export var max_enemies: int 
var enemies_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn_enemies:
		$SpawnTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage_taken():
	if health_component.health < health_component.max_health:
		$AnimationPlayer.play("half_health")
	if health_component.health <= 0:
		$AnimationPlayer.play("destroyed")
		health_component.invincible = true

func spawn_enemy():
	pass

func _on_spawn_timer_timeout():
	spawn_enemy()

#func _input(event):
	#if event is InputEventMouseButton:
		#if Geometry2D.is_point_in_polygon(event.position, spawn_area.get_polygon()):
			#print("successs") ### And it prints success
		#else:
			#print("false")
