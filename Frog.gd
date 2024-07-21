extends CharacterBody2D

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var squash = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta #add the gravity
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		print(direction)
		print(player.position)
		print(self.position)
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			print("Left")
		else:
			get_node("AnimatedSprite2D").flip_h = false
			print("Right")
		velocity.x = direction.x * SPEED
			
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0;
	move_and_slide()

#when Player body enter the area
func _on_player_detection_body_entered(body):
	if body.name == "Player":		#if the body.name is Player
		chase = true 

func _on_player_detection_body_exited(body):
	if body.name == "Player":		#if the body.name is Player
		chase = false 


func _on_player_death_body_entered(body):
	if body.name == "Player":
		Game.Gold += 5
		#bounce on frog head
		body.velocity.y *= -1
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHp -= 3
		death()
		
func death():
		Util.saveGame()
		print(Game.playerHp)
		chase = false
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
