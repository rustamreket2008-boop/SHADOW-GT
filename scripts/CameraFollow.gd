extends Camera3D

@export var follow_height: float = 4.0
@export var follow_distance: float = 8.0
@export var look_height: float = 1.0
@export var smooth_speed: float = 5.0

var target: Node3D


func _ready() -> void:
    target = get_parent().get_node_or_null("Car")


func _process(delta: float) -> void:
    if not is_instance_valid(target):
        return

    var offset: Vector3 = target.global_transform.basis * Vector3(
        0.0,
        follow_height,
        follow_distance
    )

    var desired_position: Vector3 = target.global_position + offset

    global_position = global_position.lerp(
        desired_position,
        1.0 - exp(-smooth_speed * delta)
    )

    look_at(
        target.global_position + Vector3.UP * look_height,
        Vector3.UP
    )
