extends CharacterBody3D
class_name PoliceAI

@export var move_speed: float = 14.0
@export var acceleration: float = 5.0
@export var turn_speed: float = 2.0
@export var follow_distance: float = 8.0

var target: Node3D
var chasing: bool = false


func set_target(target_node: Node3D) -> void:
    target = target_node
    chasing = is_instance_valid(target)


func stop_chase() -> void:
    chasing = false
    velocity = Vector3.ZERO


func _physics_process(delta: float) -> void:
    if not chasing or not is_instance_valid(target):
        velocity = velocity.move_toward(
            Vector3.ZERO,
            acceleration * delta
        )
        move_and_slide()
        return

    var distance := global_position.distance_to(
        target.global_position
    )

    if distance <= follow_distance:
        velocity = velocity.move_toward(
            Vector3.ZERO,
            acceleration * delta
        )
        move_and_slide()
        return

    var direction := (
        target.global_position - global_position
    )
    direction.y = 0.0

    if direction.length_squared() <= 0.001:
        return

    direction = direction.normalized()

    var target_angle := atan2(
        -direction.x,
        -direction.z
    )

    rotation.y = rotate_toward(
        rotation.y,
        target_angle,
        turn_speed * delta
    )

    var forward := -global_transform.basis.z

    velocity.x = move_toward(
        velocity.x,
        forward.x * move_speed,
        acceleration * delta
    )
    velocity.z = move_toward(
        velocity.z,
        forward.z * move_speed,
        acceleration * delta
    )

    if not is_on_floor():
        velocity.y -= 20.0 * delta
    else:
        velocity.y = 0.0

    move_and_slide()
