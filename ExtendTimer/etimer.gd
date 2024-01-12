@icon("res://addons/ExtendTimer/ETimer.svg")
class_name ETimer extends Node
#Main ExtendTimer script file
#Made by KELDOWIN
#Version: 1.0

##Process timer (Process, Physics)
@export_enum("Idle","Physics") var ProcessCallback : int
##Count when timer end (seconds)
@export_range(1, 4096, 1) var WaitTime : int = 1
##Delet when end
@export var OneShot : bool = false
##Start auto when init scene and timer end
@export var AutoStart : bool = false

#When timer end
signal TimeOut
#Every second
signal EverySecond

#When timer stop
signal TimerStop
#When timer start
signal TimerStart

##Local varible, DeltaTime += delta
var DeltaTime : float = 0.0
##Time left (TimeLeft = WaitTime)
@onready var TimeLeft : int = WaitTime

## init timer
func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	
	if AutoStart:
		TimerProcess(true)

##Start timer with setting process
func TimerProcess(Process:bool) -> void:
	match ProcessCallback:
		0:
			set_process(Process)
		1:
			set_physics_process(Process)

#PROCESS
func _process(delta:float) -> void:
	TimerFunc(delta)
	
func _physics_process(delta:float) -> void:
	TimerFunc(delta)
#PROCESS

#update timer function
func TimerFunc(delta:float) -> void:
	DeltaTime += delta
	
	if DeltaTime >= 1.0:
		DeltaTime = 0.0
		TimeLeft -= 1
		
		EverySecond.emit()
		
		#Timer end
		if TimeLeft <= 0:
			DeltaTime = 0
			TimeLeft = WaitTime
			
			TimeOut.emit()
			
			TimerProcess(false)
			
			if OneShot:
				queue_free()
			
			if AutoStart:
				TimerProcess(true)

##Stop timer
func stop() -> void:
	TimerProcess(false)
	
	TimerStop.emit()

##Start timer
func start() -> void:
	TimerProcess(true)
	
	TimerStart.emit()
