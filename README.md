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

## 🔢 Varibles and Signals
### _Varibles_
* `emun ProcessCallback : int = 0` - Timer update method ( _process(), _physic_process() )
* `range(1, 4096) WaitTime : int = 1` - After how many seconds does the timer end.
* `export OneShot : bool = false` - Whether to **delete** the timer after the end.
* `export AutoStart : bool = false` - Whether to start the timer **automatically** at the end (and start of the scene)
* `onready TimeLeft : int = 0` - A local variable used to calculate the remaining time (TimeLeft = WaitTime). 

### _Signals_
* `TimeOut` - The end of the timer
* `EverySecond` - Each subtracting second from the timer
* `TimerStop` - Timer stop use by function `$ETimer.stop()`
* `TimerStart` - Timer start use by function `$ETimer.start()`

---
Credit by Keldowin for Godot Engine 💙
Timer icon use from Godot Engine