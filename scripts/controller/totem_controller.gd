extends Node

signal move_all(direction)
signal disable_all()

var button_pressed = false
var direction = 0
var totem_list = []

enum STATE {
	SLEEP,
	IDLE,
	WALKING,
}

func _process(delta):
	var has_totem_walking = check_has_state(STATE.WALKING)
	
	if $walk_audio.playing and not has_totem_walking:
		$walk_audio.stop()
		$walk_finish_audio.play()
	
	if has_totem_walking and not $walk_audio.playing:
		$walk_audio.play()
		$walk_finish_audio.stop()

func clean_totem_list():
	totem_list = []

func register_totem(totem):
	totem_list.append(totem)

func activate_totem(dir):

	if check_has_state(STATE.SLEEP) and check_next_move(dir):
		$wake_up_audio.play()
		
	direction = dir
	button_pressed = true

func check_tile(tile_pos):
	for totem in totem_list:
		if totem.get_tile_posistion() == tile_pos:
			return false
	return true

func check_next_move(dir):
	for totem in totem_list:
		if totem.check_next_move(dir):
			return true
	return false
	
func disable_totem():
	
	if check_has_state(STATE.IDLE):
		$sleep_audio.play()
	
	button_pressed = false

func check_has_state(state, check_walk = false):
	for totem in totem_list:
		if totem.state == state:
			return true
	return false

func play_totem_sleep():
	$sleep_audio.play()
	pass

func move_all(dir):
	if check_has_state(STATE.WALKING):
		return
	
	emit_signal("move_all", dir)
