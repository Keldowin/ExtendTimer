class_name RandomTimer extends ETimer

@export_range(0.1, 86_400.0, 0.1) var time_wait_max : float = 10.0
@export_range(0.1, 86_400.0, 0.1) var time_wait_min : float = 1.0

## When enter in tree generate random time
func _enter_tree() -> void:
	if time_wait_min > time_wait_max:
		push_warning("time_wait_min is bigger then time_wait_max!")
	
	time_wait = float(randi_range(time_wait_min, time_wait_max))
	
