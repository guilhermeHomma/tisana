extends KinematicBody2D
tool

export var direction: int = 0
export var current_frame: int = 0

var SPEED = 28

var velocity = Vector2()

var next_position = Vector2()
var state = TotemController.STATE.SLEEP
var tilemap

var tile_can_walk = [4,5]

func _ready():
	TotemController.connect("move_all", self, "start_move")
	TotemController.register_totem(self)
	if get_parent().has_node("tilemap"):
		tilemap = get_parent().get_node("tilemap")
		
func change_state(new_state):
	state = new_state

func start_move(dir):
	
	if not state == TotemController.STATE.IDLE:
		return
	direction = dir
	
	if not check_next_move():
		return
	
	change_state(TotemController.STATE.WALKING)
	
	$animation.play("walk")
	set_next_position()

func check_next_move(dir = null):
	if dir == null: dir = direction
	direction = dir
	if tilemap:
		var tile_pos = tilemap.world_to_map(get_next_position())
		
		if not TotemController.check_tile(tile_pos):
			return false
			
		if tilemap.get_cellv(tile_pos) in tile_can_walk:
			return true
	
	return false

func activate(dir):
	direction = dir
	if not check_next_move():
		return
	$animation.play("wake_up")
	change_state(TotemController.STATE.IDLE)

func sleep():
	$animation.play_backwards("wake_up")
	change_state(TotemController.STATE.SLEEP)

func _set_direction(dir):
	direction = dir

func get_tile_posistion():
	if tilemap:
		return tilemap.world_to_map(position)


func move(delta):
	var movement = (next_position - position)

	if abs(position.x - next_position.x) < 1:
		position.x = next_position.x
	if abs(position.y - next_position.y) < 1:
		position.y = next_position.y

	if position == next_position:
		change_state(TotemController.STATE.IDLE)
		$animation.stop()
		current_frame = 2
	else:
		position = position.linear_interpolate(next_position, SPEED * delta / position.distance_to(next_position))
		

func _physics_process(delta):
	$sprite.frame_coords = Vector2(current_frame, direction)
	
	if Engine.editor_hint:
		return
	
	$Label.text = String(state)
	
	match state:
		TotemController.STATE.SLEEP:
			if TotemController.button_pressed:
				activate(TotemController.direction)
		
		TotemController.STATE.IDLE:
			if not TotemController.button_pressed or not check_next_move():
				sleep()
			
		TotemController.STATE.WALKING:
			move(delta)

func get_next_position():
	match direction:
		0:
			return position + Vector2(-16, -8)
		1:
			return position + Vector2(16, -8)
		2:
			return position + Vector2(-16, 8)
		3:
			return position + Vector2(16, 8)
	
func set_next_position():
	next_position = get_next_position()
	



