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
    var throttle := Input.get_action_strength("accelerate")
    var reverse := Input.get_action_strength("reverse")
    var steering := Input.get_axis(
        "steer_right",
        "steer_left"
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

    # Braking
    if Input.is_action_pressed("brake"):
        current_speed = move_toward(
            current_speed,
            0.0,
            brake_power * delta
        )

    current_speed = clampf(
        current_speed,
        -reverse_speed,
        max_speed
    )

    # Steering
    if absf(current_speed) > 0.1:
        var speed_factor := clampf(
            absf(current_speed) / max_speed,
            0.25,
            1.0
        )

        var steering_direction := signf(current_speed)

        rotate_y(
            steering
            * steering_speed
            * speed_factor
            * steering_direction
            * delta
        )

    # Movement
    var forward := -global_transform.basis.z

    velocity.x = forward.x * current_speed
    velocity.z = forward.z * current_speed

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = 0.0

    move_and_slide()

    # Engine sound connection for later
    if is_instance_valid(audio_manager):
        var speed_ratio := absf(current_speed) / max_speed
        var engine_power := maxf(
            throttle,
            speed_ratio * 0.6
        )
        audio_manager.update_engine_sound(engine_power)
