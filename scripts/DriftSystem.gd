
extends RefCounted
class_name DriftSystem

var drift_amount: float = 0.0
var drift_threshold: float = 0.35
var drift_build_rate: float = 1.8
var drift_recovery_rate: float = 1.2
var drift_score: float = 0.0

func update_drift(
    speed: float,
    steering: float,
    handbrake: bool,
    delta: float
) -> float:
    var intensity: float = absf(steering) * absf(speed) / 20.0

    if handbrake and intensity > drift_threshold:
        drift_amount = move_toward(
            drift_amount, minf(intensity, 1.0),
            drift_build_rate * delta
        )
        drift_score += drift_amount * absf(speed) * delta
    else:
        drift_amount = move_toward(
            drift_amount, 0.0,
            drift_recovery_rate * delta
        )

    return drift_amount

func is_drifting() -> bool:
    return drift_amount >= drift_threshold

func get_drift_score() -> int:
    return int(drift_score)

func reset_score() -> void:
    drift_score = 0.0
