@icon('res://addons/ExtendTimer/ETimer.svg')
class_name ETimer extends Node
## INFO Main ExtendTimer class file
##Made by KELDOWIN
##Version: 1.1

## Process timer (Process, Physics)
@export_enum('Idle','Physics') var process_callback : int
## Count when timer end (seconds)
@export_range(0.1, 86_400.0, 0.1) var time_wait : float = 1.0 #INFO Default 1 sec. Max 24 hours  
## Delet when end
@export var oneshot : bool = false
## Start auto when init scene and timer end
@export var autostart : bool = false
## Give a signal for a certain time 
##WARNING(The value must time_wait >= time_emit[] and time_wait != time_emit[])
@export var time_emit : Array[int] = []

## Signal when timer is end
signal timeout
## Signal every timer milisecond
signal every_milisecond
## Signal every timer second
signal every_second

## Signal when timer it reaches for a certain time value in time_emit : Array[float]
signal every_time(time_left: int)

## Signal when timer stop
signal timer_stop
## Signal when timer start
signal timer_start

## Local varible (DeltaTime += delta)
var delta_time : float = 0.0
## Time left (time_left = WaitTime) INFO(but time_left changes when timer work)
@onready var time_left : float = time_wait

var timer_work : bool = false # Work or not work timer

var delta_time_tmp : float = 0.0 # Last time 

## Init timer
func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	
	if autostart:
		timer_process(true)

## Start timer with setting process
func timer_process(process: bool) -> void:

	match process_callback:
		0:
			set_process(process)
		1:
			set_physics_process(process)
			
	timer_work = process

##NOTE Timer proccess func
#PROCESS ALERT(Privat core func)
func _process(delta:float) -> void:
	timer_update(delta)
	
func _physics_process(delta:float) -> void:
	timer_update(delta)
#PROCESS ALERT(Privat core func)

#update timer function ALERT(Privat core func)
func timer_update(delta: float) -> void:
	delta_time += delta
	
	if delta_time >= 0.1: #Every milisecond
		delta_time = 0.0
		delta_time_tmp += 0.1
		
		time_left -= 0.1
		
		every_milisecond.emit()

		if delta_time_tmp >= 1.0: #Every second 
			delta_time_tmp = 0.0
			every_second.emit()
	
			if roundi(time_left) in time_emit:
				every_time.emit(roundi(time_left))
		
		#Timer end
		if time_left <= 0:
			delta_time = 0
			time_left = time_wait
			
			timer_process(false)
			
			timeout.emit()
			
			if oneshot: queue_free()
			
			if autostart: timer_process(true)

## Stop timer
func stop() -> void:
	timer_process(false)
	
	timer_stop.emit()

## Start timer
func start() -> void:
	timer_process(true)
	
	timer_start.emit()

## Get timer time in this time WARNING(with round)
func get_time_left() -> int:
	return roundi(time_left)
	
## Get timer total time
func get_time_wait() -> float:
	return time_wait

## Update time_left to time_wait (start timer again) without emit timeout
func reset() -> void:
	delta_time = 0
	time_left = time_wait
	
	timer_process(true)
