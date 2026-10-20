extends Node
class_name CameraManager

signal camera_mode_changed(mode_name: String)

enum CameraMode {
    CHASE,
    COCKPIT
}

@export var car: Node3D
@export var chase_camera: Camera3D
@export var cockpit_camera: Camera3D

var current_mode: CameraMode = CameraMode.CHASE


func _ready() -> void:
    set_camera_mode(CameraMode.CHASE)


func set_camera_mode(mode: CameraMode) -> void:
    current_mode = mode

    if is_instance_valid(chase_camera):
        chase_camera.current = mode == CameraMode.CHASE

    if is_instance_valid(cockpit_camera):
        cockpit_camera.current = mode == CameraMode.COCKPIT

    camera_mode_changed.emit(get_camera_mode_name())


func toggle_camera() -> void:
    if current_mode == CameraMode.CHASE:
        set_camera_mode(CameraMode.COCKPIT)
    else:
        set_camera_mode(CameraMode.CHASE)


func get_camera_mode_name() -> String:
    if current_mode == CameraMode.CHASE:
        return "CHASE"

    return "COCKPIT"
