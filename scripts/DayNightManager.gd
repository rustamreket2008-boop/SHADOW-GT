extends Node
class_name DayNightManager

signal time_changed(hour: float)
signal period_changed(period_name: String)

@export var day_length_seconds: float = 600.0

var current_hour: float = 12.0
var time_speed: float = 1.0
var running: bool = true
var last_period: String = ""


func _process(delta: float) -> void:
    if not running or day_length_seconds <= 0.0:
        return

    current_hour += (
        24.0 / day_length_seconds
    ) * delta * time_speed

    if current_hour >= 24.0:
        current_hour = fmod(current_hour, 24.0)

    time_changed.emit(current_hour)

    var period := get_period_name()

    if period != last_period:
        last_period = period
        period_changed.emit(period)


func set_time(hour: float) -> void:
    current_hour = fposmod(hour, 24.0)
    last_period = get_period_name()
    time_changed.emit(current_hour)
    period_changed.emit(last_period)


func set_time_speed(speed: float) -> void:
    time_speed = maxf(speed, 0.0)


func pause_time() -> void:
    running = false


func resume_time() -> void:
    running = true


func get_period_name() -> String:
    if current_hour >= 6.0 and current_hour < 12.0:
        return "Субҳ"

    if current_hour >= 12.0 and current_hour < 17.0:
        return "Рӯз"

    if current_hour >= 17.0 and current_hour < 20.0:
        return "Шом"

    return "Шаб"


func get_formatted_time() -> String:
    var hour := int(floor(current_hour))
    var minute := int(floor(
        (current_hour - float(hour)) * 60.0
    ))

    return "%02d:%02d" % [hour, minute]
