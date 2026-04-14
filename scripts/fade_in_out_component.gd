extends Node
class_name FadeInOutComponent

@export var black_rectangle : ColorRect
@export var fade_in_timer : Timer
@export var fade_out_timer : Timer

signal fade_in_done
signal fade_out_done

var fade := true

func _ready() -> void:
	set_process(false)
	fade_in_timer.timeout.connect(fade_in_timer_ended)
	fade_out_timer.timeout.connect(fade_out_timer_ended)
	fade_in()

func fade_in(time := fade_in_timer.wait_time):
	fade_in_timer.wait_time = time
	fade_in_timer.start()
	fade = true
	set_process(true)

func fade_out(time := fade_out_timer.wait_time):
	fade_out_timer.wait_time = time
	fade_out_timer.start()
	fade = false
	set_process(true)
	
	
func _process(delta: float) -> void:
	if fade:
		var timer_percentage = fade_in_timer.time_left / fade_in_timer.wait_time
		black_rectangle.color.a = timer_percentage
	else:
		var timer_percentage = fade_out_timer.time_left / fade_out_timer.wait_time
		black_rectangle.color.a = 1 - timer_percentage

func fade_in_timer_ended():
	set_process(false)
	fade_in_done.emit()
	
func fade_out_timer_ended():
	set_process(false)
	fade_out_done.emit()
