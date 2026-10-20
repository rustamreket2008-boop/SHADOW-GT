
extends Node
class_name RaceManager

signal race_started
signal race_finished(race_time: float, reward: int)
signal race_progress_changed(progress: float)

@export var race_distance: float = 1000.0
@export var base_reward: int = 1000

var race_active: bool = false
var race_time: float = 0.0
var distance_covered: float = 0.0


func start_race() -> void:
    if race_active:
        return

    race_active = true
    race_time = 0.0
    distance_covered = 0.0
    race_started.emit()


func update_race(delta: float, car_speed: float) -> void:
    if not race_active:
        return

    race_time += delta
    distance_covered += absf(car_speed) * delta

    var progress: float = clampf(
        distance_covered / maxf(race_distance, 1.0),
        0.0,
        1.0
    )

    race_progress_changed.emit(progress)

    if distance_covered >= race_distance:
        finish_race()


func finish_race() -> void:
    if not race_active:
        return

    race_active = false

    var time_bonus: int = maxi(
        0,
        500 - int(race_time * 5.0)
    )

    var reward: int = base_reward + time_bonus

    race_finished.emit(race_time, reward)


func cancel_race() -> void:
    race_active = false
    race_time = 0.0
    distance_covered = 0.0


func get_progress() -> float:
    if race_distance <= 0.0:
        return 0.0

    return clampf(
        distance_covered / race_distance,
        0.0,
        1.0
    )


func get_formatted_time() -> String:
    var minutes: int = int(race_time) / 60
    var seconds: int = int(race_time) % 60
    var milliseconds: int = int(
        (race_time - floorf(race_time)) * 1000.0
    )

    return "%02d:%02d.%03d" % [
        minutes,
        seconds,
        milliseconds
    ]
