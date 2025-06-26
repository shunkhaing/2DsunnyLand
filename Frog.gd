extends CharacterBody2D

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var squash = false
@onready var anim2d = get_node("AnimatedSprite2D")

func _ready():
	anim2d.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta #add the gravity
	if chase == true:
		if anim2d.animation != "Death":
			anim2d.play("Jump")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim2d.flip_h = true
		else:
			anim2d.flip_h = false
		velocity.x = direction.x * SPEED
			
	else:
		if anim2d.animation != "Death":
			anim2d.play("Idle")
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
		Game.playerX = player.position.x 
		Game.playerY = player.position.y
		Util.saveGame()
		print(Game.playerHp)
		chase = false
		anim2d.play("Death")
		await anim2d.animation_finished
		self.queue_free()
