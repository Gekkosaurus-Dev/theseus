extends CharacterBody2D

enum EnemyStates {ATTACKING, MOVING, IDLE}
var enemy_state
var player
var max_speed = 200

func _ready():
	enemy_state = EnemyStates.MOVING
	player = $"../player_new"

func _physics_process(delta):
	if (enemy_state == EnemyStates.IDLE):
		#animation_player.play("idle")
		pass
	elif (enemy_state == EnemyStates.MOVING):
		#animation_player.play("walk")
		
		var direction = global_position.direction_to(player.get_target_position())
		velocity = direction * max_speed
		move_and_slide()
	
func start_particles():
	print($DirectionFlipper/GPUParticles2D.process_material.gravity)
	print($DirectionFlipper.flipped)
	if ($DirectionFlipper.flipped == false):
		$DirectionFlipper/GPUParticles2D.process_material.gravity.x = 96.895
	elif($DirectionFlipper.flipped == true):
		$DirectionFlipper/GPUParticles2D.process_material.gravity.x = -96.895
	$DirectionFlipper/GPUParticles2D.emitting = true

	
func end_particles():
	$DirectionFlipper/GPUParticles2D.emitting = false



func _on_timer_timeout():
	$DirectionFlipper/AnimationPlayer.play("attack")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		$DirectionFlipper/AnimationPlayer.play("idle")
		$Timer.start()



func _on_detection_area_body_entered(body):
	pass # Replace with function body.


func _on_attack_area_body_entered(body):
	pass # Replace with function body.
