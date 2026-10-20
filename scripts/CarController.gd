extends CharacterBody3D
class_name CarController

@export_group("Engine")
@export var acceleration: float = 18.0
@export var max_speed: float = 35.0
@export var reverse_speed: float = 7.0

@export_group("Handling")
@export var steering_speed: float = 1.8
@export var brake_power: float = 25.0
@export var drag: float = 4.0
@export var gravity: float = 20.0

@export_group("Audio")
@export var audio_manager: AudioManager

var current_speed: float = 0.0


func _physics_process(delta: float) -> void:
    var throttle: float = Input.get_action_strength("accelerate")
    var reverse: float = Input.get_action_strength("reverse")

    # Steering: A = left, D = right
    var steering: float = Input.get_axis(
        "steer_left",
        "steer_right"
    )

    # Acceleration and reverse
    if throttle > 0.0:
        current_speed += acceleration * throttle * delta
    elif reverse > 0.0:
        current_speed -= acceleration * reverse * delta
    else:
        current_speed = move_toward(
            current_speed,
            0.0,
            drag * delta
        )

    # Brake
    if Input.is_action_pressed("brake"):
        current_speed = move_toward(
            current_speed,
            0.0,
            brake_power * delta
        )

    # Speed limits
    current_speed = clampf(
        current_speed,
        -reverse_speed,
        max_speed
    )

    # Steering
    if absf(current_speed) > 0.1:
        var speed_factor: float = clampf(
            absf(current_speed) / max_speed,
            0.25,
            1.0
        )

        rotate_y(
            steering
            * steering_speed
            * speed_factor
            * signf(current_speed)
            * delta
        )

    # Forward movement
    var forward: Vector3 = -global_transform.basis.z
    velocity.x = forward.x * current_speed
    velocity.z = forward.z * current_speed

    # Gravity
    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = 0.0

    move_and_slide()

    # Engine sound
    if is_instance_valid(audio_manager):
        var speed_ratio: float = absf(current_speed) / max_speed
        var engine_power: float = maxf(
            throttle,
            speed_ratio * 0.6
        )
        audio_manager.update_engine_sound(engine_power)
