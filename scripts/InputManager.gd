extends Node
class_name GameInputManager

signal nitro_pressed
signal camera_pressed
signal pause_pressed

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("nitro"):
        nitro_pressed.emit()

    if Input.is_action_just_pressed("change_camera"):
        camera_pressed.emit()

    if Input.is_action_just_pressed("pause"):
        pause_pressed.emit()


func is_accelerating() -> bool:
    return Input.is_action_pressed("accelerate")


func is_braking() -> bool:
    return Input.is_action_pressed("brake")


func get_steering() -> float:
    return Input.get_axis("steer_left", "steer_right")
