@icon("res://addons/ExtendTimer/ETimer.svg")
class_name ETimer extends Node
#Main ExtendTimer script file
#Made by KELDOWIN

@export_enum("Idle","Physics") var ProcessCallback : int
@export_range(1, 4096, 1) var WaitTime : int = 1
@export var OneShot : bool = false
@export var AutoStart : bool = false

signal TimeOut
signal OnEverySecond

signal TimerStop
signal TimerStart

var DeltaTime : float = 0.0
@onready var TimeLeft : int = WaitTime

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	
	if AutoStart:
		TimerProcess(true)

func TimerProcess(Process:bool) -> void:
	match ProcessCallback:
		0:
			set_process(Process)
		1:
			set_physics_process(Process)
			
func _process(delta:float) -> void:
	TimerFunc(delta)
	
func _physics_process(delta:float) -> void:
	TimerFunc(delta)

func TimerFunc(delta:float) -> void:
	DeltaTime += delta
	
	if DeltaTime >= 1.0:
		DeltaTime = 0.0
		TimeLeft -= 1
		
		OnEverySecond.emit()
		
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
			
func stop() -> void:
	TimerProcess(false)
	
	TimerStop.emit()
	
func start() -> void:
	TimerProcess(true)
	
	TimerStart.emit()
