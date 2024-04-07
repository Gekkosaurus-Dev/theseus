extends CharacterBody2D

@export var velocity_component: Node
@export var hitbox: Area2D
@export var hitbox_collider: CollisionPolygon2D
var attack_up = true

@export var invincible = false
@export var attack_speed = 1
@export var attack_cooldown = 0.5

var attacking = false
var attack_dashing = false
var can_attack = true
var can_move = true


var dashing = false
var can_dash = true

func _ready():
	pass
	
func _physics_process(_delta):
	get_input()
	#print("player velocity = " + str(velocity))
	point_cursor()
	move_and_slide()
	
func point_cursor():
	$DirectionPointer.look_at(get_global_mouse_position())
	
func get_input():
	if Input.is_action_just_pressed("attack_melee"):
		try_attack()
		#$Icon/GPUParticles2D.emitting = true
	if Input.is_action_just_pressed("dash"):
		try_dash()	
	if can_move:
		if attack_dashing:
				var direction = global_position.direction_to(get_global_mouse_position())
				velocity = direction * velocity_component.attack_move_speed
		else:
			var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if direction:
				if dashing:
					velocity = direction * velocity_component.dash_move_speed
				else:
					velocity = direction * velocity_component.max_speed
			else:
				velocity.y = move_toward(velocity.y, 0, velocity_component.max_speed)
				velocity.x = move_toward(velocity.x, 0, velocity_component.max_speed)		
	else:
		velocity.y = move_toward(velocity.y, 0, velocity_component.max_speed)
		velocity.x = move_toward(velocity.x, 0, velocity_component.max_speed)
		
		#
	#var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#if direction or attack_dashing:
		#if attacking:
			#direction = global_position.direction_to(get_global_mouse_position())
			#velocity = direction * velocity_component.attack_move_speed
		#elif can_attack:
			#if dashing:
				#velocity = direction * velocity_component.dash_move_speed
			#else:
				#velocity = direction * velocity_component.max_speed
	#else:
		#velocity.y = move_toward(velocity.y, 0, velocity_component.max_speed)
		#velocity.x = move_toward(velocity.x, 0, velocity_component.max_speed)
	#
	#var direction2 = Input.get_vector("move_left", "move_right")
	#if direction > 0:
		#$Sprite2D.flip_h = true
	#elif direction < 0:
		#$Sprite2D.flip_h = false
	#
	#if (Input.is_action_just_pressed("move_left")):
		##$Sprite2D.flip_h = true
		#scale.x = -1
		#print (scale.x)
	#elif (Input.is_action_just_pressed("move_right")):
		#scale.x = 1
		#print (scale.x)
		##$Sprite2D.flip_h = false
	#if direction.x > 0:
		#scale.x = -1
		#print (scale.x)
		##$AnimationPlayer.play("right_run")
	#elif direction.x < 0:
		#scale.x = 1
		#print (scale.x)
		#$AnimationPlayer.play("left_run")
	#if direction.y > 0:
		#$AnimationPlayer.play("front_run")
	#elif direction.y < 0:
		#$AnimationPlayer.play("back_run")

func try_attack():
	#var attacking = false
	#var attack_dashing = false
	#var can_attack = true
	#var can_move = true
	if (can_attack):
		attacking = true
		$attack_cooldwon.start()
		attack_dashing = true
		#print("attack move timer")
		$attack_move.start()
		can_attack = false
		
		if attack_up:
			$DirectionFlipper/AnimationPlayer.play("attack_1")
			#print("attack up")
			attack_up = false
		else:
			$DirectionFlipper/AnimationPlayer.play("attack_2")
			#print("attack down")
			attack_up = true
		
	#var attack_state = attack_state * -1
	#if (attack_state == 1):
		#$DirectionFlipper/AnimationPlayer.play("attack_1")
	#if (attack_state == -1):
		#$DirectionFlipper/AnimationPlayer.play("attack_2")
	##await get_tree().create_timer(0.1).timeout
	#hitbox_collider.disabled = true

func try_dash():
	dashing = true
	invincible = true
	can_dash = false
	$dash_timer.start()
	$dash_cooldown.start()

func damage_taken():
	if !invincible:
		#print("PLAYER TOOK DAMAGE")
		$DirectionFlipper/Sprite2D.modulate = "000000"
		await get_tree().create_timer(0.1).timeout
		$DirectionFlipper/Sprite2D.modulate = "ffffff"
		#$DirectionFlipper/AnimationPlayer.play("hit_flash")
		
	


func _on_attack_cooldwon_timeout():
	#print("huh")
	can_attack = true


func _on_attack_move_timeout():
	attack_dashing = false
	can_move = false
	#print("start cooldown")
	$attack_move_cooldown.start()


func _on_attack_move_cooldown_timeout():
	print("coold")
	can_move = true


func _on_dash_timer_timeout():
	dashing = false
	invincible = false


func _on_dash_cooldown_timeout():
	can_dash = true
