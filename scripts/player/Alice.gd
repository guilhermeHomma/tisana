extends KinematicBody2D


export var speed = 45

var velocity = Vector2()
onready var tilemap: TileMap = get_parent().get_node("tilemap")

enum STATE {
	PLAY,
	CUTSCENE
}

func _ready():
	pass

func _physics_process(delta):

	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		velocity.y *= 0.6
		set_ground_feedback_position()
	
	set_animation()
	move_and_slide(velocity, Vector2.UP)
	
	
func set_animation():
	if abs(velocity.x) > 0:
		$sprite.flip_h = true if velocity.x < 0 else false 
	
	if velocity != Vector2.ZERO:
		if velocity.y < 0:
			$animation.play("run-back")
		else:
			$animation.play("run-front")
	else:
		$animation.play("idle")
		
		
	
func set_ground_feedback_position():
	var position_on_tilemap = tilemap.world_to_map(global_position + Vector2(0, 11))
	$ground_feedback.global_position = tilemap.map_to_world(position_on_tilemap)
	pass
	
