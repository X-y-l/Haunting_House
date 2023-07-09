extends Control

@export var chars_typed = 0
@export var full_text = ""
@export var finished = false

signal waiting_for_user

func _ready():
	$audio.stream.set_loop_mode(0)

func set_new_text(txt):
	full_text = txt
	finished = false
	set_chars_typed(0)

func set_chars_typed(n):
	chars_typed = n
	$lbl.text = full_text.substr(0, n)

func _on_timer_timeout():
	if len(full_text) == 0:
		return
		
	set_chars_typed(chars_typed + 1)
	if chars_typed >= len(full_text):
		chars_typed = len(full_text)
		finished = true
		waiting_for_user.emit()
		pause()
	if full_text[chars_typed-1] == "\n":
		waiting_for_user.emit()
		pause()

func pause():
	$timer.stop()
	$audio_timer.stop()
	$audio.stop()

func unpause():
	$timer.start()
	$audio_timer.start()

func _process(delta):
	pass
	
func _on_audio_timer_timeout():
	$audio.play()
