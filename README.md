# ExtendTimer for [Godot Engine](https://godotengine.org/) 4.x
Godot 4.x plugin. Adds an improved timer with additional signals

## 📂 Installation
1. Download **ExtendTimer** addon.
2. Extract the `ExtendTimer` folder into the `addons` folder within your Godot project directory.
3. Enable the addon in Godot's plugins tab. (`Project > Project Settings > Plugins`)

## 📃 Usage
* Add the `ETimer` node to your scene(s) like any regular node in Godot.
* Adjust the wait time values to your liking through the inspector tab.
* Start the `ETimer` by calling the `$ETimer.start()` function or by enabling **autostart** in the inspector tab.

## 🔢 Varibles, signals, methods
### _Varibles_
* `emun('Idle','Physics') process_callback : int` - Timer update method (_process(), _physic_process())
* `range(0.1, 86400.0, 0.1) time_wait : float = 1.0` - After how many **milliseconds** does the timer end. (1.0 = one second)
* `export oneshot : bool = false` - Whether to **delete** the timer after the end.
* `export autostart : bool = false` - Whether to start the timer **automatically** at the end (and start of the scene)
* `onready time_left : float = 0.0` - A local variable used to calculate the remaining time (time_left = time_wait). 
* `export time_emit : Array[float]` - A certain second at which the signal will be triggered `every_time(time_left: int)` and return this emit second

### _Signals_
* `timeout` - The end of the timer
* `every_second` - Each subtracting second from the timer
* `every_milisecond` - Each subtracting millisecond from the timer
* `every_time(time_left: int)` - Each subtracting **time_emit** from the timer
* `timer_stop` - Timer stop use by function `$ETimer.stop()`
* `timer_start` - Timer start use by function `$ETimer.start()`

### _Methods_
* `.start() -> void` - Start timer
* `.stop() -> void` - Stop timer
* `.reset() -> void` - Reset timer (time_left = time_wait)
* `.get_time_left() -> int` - Return time_left like round int
* `.get_time_wait() -> float` - Return time_wait

---
Credit by *Keldowin* for Godot Engine 💙

**Timer icon use from Godot Engine**