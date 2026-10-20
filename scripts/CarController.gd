
extends CharacterBody3D
class_name CarController

@export var acceleration: float = 18.0
@export var reverse_speed: float = 7.0
@export var max_speed: float = 35.0
@export var steering_speed: float = 1.8
@export var brake_power: float = 25.0
@export var audio_manager: AudioManager

var current_speed: float = 0.0


func _physics_process(delta: float) -> void:
    var throttle: float = Input.get_action_strength("accelerate")
    var reverse: float = Input.get_action_strength("reverse")
    var steering: float = Input.get_axis("steer_right", "steer_left")

    if throttle > 0.0:
        current_speed += acceleration * throttle * delta
    elif reverse > 0.0:
        current_speed -= acceleration * reverse * delta
    else:
        current_speed = move_toward(current_speed, 0.0, 4.0 * delta)

    if Input.is_action_pressed("brake"):
        current_speed = move_toward(
            current_speed, 0.0, brake_power * delta
        )

    current_speed = clampf(current_speed, -reverse_speed, max_speed)

    if absf(current_speed) > 0.1:
        rotate_y(steering * steering_speed * delta)

    var forward: Vector3 = -global_transform.basis.z
    velocity.x = forward.x * current_speed
    velocity.z = forward.z * current_speed
    velocity.y -= 20.0 * delta

    move_and_slide()

    if is_instance_valid(audio_manager):
        var speed_ratio: float = absf(current_speed) / max_speed
        var engine_power: float = maxf(throttle, speed_ratio * 0.6)
        audio_manager.update_engine_sound(engine_power)
