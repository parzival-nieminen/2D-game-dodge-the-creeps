extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	
	# get random index from the list
	var index = randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[index]
	


func _on_VisibilityNotifier2D_screen_exited():
	# remove the mob from mem
	queue_free()
