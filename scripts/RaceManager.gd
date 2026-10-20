extends Node
class_name RaceManager

signal race_started
signal race_finished(final_time: float)
signal lap_completed(lap_number: int, lap_time: float)
signal race_time_updated(time: float)

@export var total_laps: int = 3

var race_running: bool = false
var race_time: float = 0.0
var lap_time: float = 0.0
var current_lap: int = 1


func start_race() -> void:
    race_running = true
    race_time = 0.0
    lap_time = 0.0
    current_lap = 1
    race_started.emit()


func _process(delta: float) -> void:
    if not race_running:
        return

    race_time += delta
    lap_time += delta
    race_time_updated.emit(race_time)


func complete_lap() -> void:
    if not race_running:
        return

    lap_completed.emit(current_lap, lap_time)

    if current_lap >= total_laps:
        finish_race()
        return

    current_lap += 1
    lap_time = 0.0


func finish_race() -> void:
    if not race_running:
        return

    race_running = false
    race_finished.emit(race_time)


func reset_race() -> void:
    race_running = false
    race_time = 0.0
    lap_time = 0.0
    current_lap = 1


func get_formatted_time(time_value: float) -> String:
    var minutes := int(time_value / 60.0)
    var seconds := int(fmod(time_value, 60.0))
    var milliseconds := int(
        fmod(time_value, 1.0) * 100.0
    )

    return "%02d:%02d.%02d" % [
        minutes,
        seconds,
        milliseconds
    ]
