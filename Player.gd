extends Area2D

signal hit

export var speed = 400.0

var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	# press more then one directions
	# prevent with normalized
	if direction.length() > 1:
		direction = direction.normalized()
	if direction.length() > 0:
		# short hand for: get_node("AnimatedSprite").play()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# move the player
	position += direction * speed * delta
	
	# move the player only in the viewport
	position.x = clamp(position.x, 0 , screen_size.x)
	position.y = clamp(position.y, 0 , screen_size.y)
	
	if direction.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false
	elif direction.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = direction.y > 0
		$AnimatedSprite.flip_h = false
		
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	
func _on_Player_body_entered(body):
	hide()
	# carfull set disabled to TRUE for the physic-engine calculation
	$CollisionShape2D.call_deferred("disabled", true)
	emit_signal("hit")
	
