@icon("res://addons/ExtendTimer/ETimer.svg")
class_name ETimer extends Node
#Main ExtendTimer script file
#Made by KELDOWIN
#Version: 1.0

##Process timer (Process, Physics)
@export_enum("Idle","Physics") var process_callback : int
##Count when timer end (seconds)
@export_range(1, 4096, 1) var wait_time : int = 1
##Delet when end
@export var oneshot : bool = false
##Start auto when init scene and timer end
@export var autostart : bool = false

#When timer end
signal timeout
#Every second
signal every_second

#When timer stop
signal timer_stop
#When timer start
signal timer_start

##Local varible, DeltaTime += delta
var delta_time : float = 0.0
##Time left (TimeLeft = WaitTime)
@onready var timeleft : int = wait_time

## init timer
func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	
	if autostart:
		timer_process(true)

##Start timer with setting process
func timer_process(process:bool) -> void:
	match process_callback:
		0:
			set_process(process)
		1:
			set_physics_process(process)

#PROCESS
func _process(delta:float) -> void:
	timer_update(delta)
	
func _physics_process(delta:float) -> void:
	timer_update(delta)
#PROCESS

#update timer function
func timer_update(delta:float) -> void:
	delta_time += delta
	
	if delta_time >= 1.0:
		delta_time = 0.0
		timeleft -= 1
		
		every_second.emit()
		
		#Timer end
		if timeleft <= 0:
			delta_time = 0
			timeleft = wait_time
			
			timeout.emit()
			
			timer_process(false)
			
			if oneshot:
				queue_free()
			
			if autostart:
				timer_process(true)

##Stop timer
func stop() -> void:
	timer_process(false)
	
	timer_stop.emit()

##Start timer
func start() -> void:
	timer_process(true)
	
	timer_start.emit()
