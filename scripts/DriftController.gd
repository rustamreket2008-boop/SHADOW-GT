
extends Node
class_name DriftController

signal drift_started
signal drift_ended
signal drift_score_changed(score: int)

@export var minimum_drift_speed: float = 12.0
@export var drift_score_rate: float = 100.0
@export var steering_threshold: float = 0.5

var drifting: bool = false
var drift_score: int = 0
var drift_time: float = 0.0


func update_drift(
    speed: float,
    steering: float,
    delta: float
) -> void:
    var should_drift := (
        absf(speed) >= minimum_drift_speed
        and absf(steering) >= steering_threshold
    )

    if should_drift and not drifting:
        drifting = true
        drift_time = 0.0
        drift_started.emit()

    elif not should_drift and drifting:
        drifting = false
        drift_ended.emit()

    if drifting:
        drift_time += delta

        var points := int(
            drift_score_rate
            * (absf(speed) / minimum_drift_speed)
            * delta
        )

        drift_score += points
        drift_score_changed.emit(drift_score)


func reset_drift() -> void:
    drifting = false
    drift_score = 0
    drift_time = 0.0
    drift_score_changed.emit(drift_score)
