
extends RefCounted
class_name CarPhysics

var acceleration: float = 18.0
var max_speed: float = 35.0
var reverse_speed: float = 7.0
var brake_power: float = 25.0
var drag: float = 4.0

func update_speed(
    speed: float,
    throttle: float,
    reverse: float,
    braking: bool,
    delta: float
) -> float:
    if throttle > 0.0:
        speed += acceleration * throttle * delta
    elif reverse > 0.0:
        speed -= acceleration * reverse * delta
    else:
        speed = move_toward(speed, 0.0, drag * delta)

    if braking:
        speed = move_toward(speed, 0.0, brake_power * delta)

    return clamp(speed, -reverse_speed, max_speed)
