extends CharacterBody2D

@export var velocity_component: Node
@export var hitbox: Area2D
@export var hitbox_collider: CollisionShape2D
var max_speed
var acceleration_value

func _ready():
	max_speed = velocity_component.max_speed
	acceleration_value = velocity_component.acceleration_value
	
func _physics_process(_delta):
	get_input()
	#print("player velocity = " + str(velocity))
	point_hitbox()
	move_and_slide()
	
func point_hitbox():
	$Icon.look_at(get_global_mouse_position())
	
func get_input():
	if Input.is_action_just_pressed("attack_melee"):
		try_attack()
		#$Icon/GPUParticles2D.emitting = trueaaaaaaaa
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * max_speed
	else:
		velocity.y = move_toward(velocity.y, 0, max_speed)
		velocity.x = move_toward(velocity.x, 0, max_speed)
		
	if direction.x > 0:
		$AnimationPlayer.play("right_run")
	elif direction.x < 0:
		$AnimationPlayer.play("left_run")
	if direction.y > 0:
		$AnimationPlayer.play("front_run")
	elif direction.y < 0:
		$AnimationPlayer.play("back_run")

func try_attack():
	hitbox_collider.disabled = false
	await get_tree().create_timer(0.1).timeout
	hitbox_collider.disabled = true

func damage_taken():
	$AnimationPlayer.play("hit_flash")
	print("PLAYER TOOK DAMAGE")
