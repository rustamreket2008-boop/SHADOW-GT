
extends Camera3D
class_name CameraController

@export var target: Node3D
@export var follow_distance: float = 7.0
@export var follow_height: float = 3.0
@export var follow_smoothness: float = 5.0
@export var look_height: float = 1.2

var cockpit_mode: bool = false

func _physics_process(delta: float) -> void:
    if not is_instance_valid(target):
        return

    if cockpit_mode:
        var cockpit_position: Vector3 = (
            target.global_position
            + target.global_transform.basis.z * 0.35
            + Vector3.UP * 1.15
        )
        global_position = global_position.lerp(
            cockpit_position,
            clampf(delta * follow_smoothness, 0.0, 1.0)
        )
    else:
        var behind: Vector3 = (
            target.global_transform.basis.z * follow_distance
            + Vector3.UP * follow_height
        )
        var desired_position: Vector3 = (
            target.global_position + behind
        )
        global_position = global_position.lerp(
            desired_position,
            clampf(delta * follow_smoothness, 0.0, 1.0)
        )

    look_at(
        target.global_position + Vector3.UP * look_height,
        Vector3.UP
    )

func toggle_camera_mode() -> void:
    cockpit_mode = not cockpit_mode
