extends Node3D
class_name TrafficCar

@export var move_speed: float = 12.0
@export var despawn_distance: float = 30.0

var player_car: Node3D


func _process(delta: float) -> void:
    # Мошинҳои трафик ба тарафи бозингар наздик мешаванд.
    position.z += move_speed * delta

    if is_instance_valid(player_car):
        if global_position.distance_to(
            player_car.global_position
        ) > 250.0:
            queue_free()
            return

    if position.z > despawn_distance:
        queue_free()


func set_player(target: Node3D) -> void:
    player_car = target
