extends Node2D

export var song: AudioStream
export var song1: AudioStream

func _ready():
	Music.play_song(song, 0.0, -10)
	Music.play_song(song1, 0.0, -100, 1)
	pass
