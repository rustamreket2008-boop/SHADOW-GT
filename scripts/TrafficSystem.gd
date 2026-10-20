
extends Node3D
class_name TrafficSystem

@export var traffic_car_scene: PackedScene
@export var road_length: float = 100.0
@export var road_width: float = 10.0
@export var spawn_interval: float = 3.0
@export var traffic_speed_min: float = 8.0
@export var traffic_speed_max: float = 18.0
@export var max_traffic_cars: int = 8

var traffic_cars: Array[Node3D] = []
var spawn_timer: float = 0.0


func _process(delta: float) -> void:
    spawn_timer += delta

    traffic_cars = traffic_cars.filter(
        func(car: Node3D) -> bool:
            return is_instance_valid(car)
    )

    if spawn_timer >= spawn_interval:
        spawn_timer = 0.0
        spawn_traffic_car()

    move_traffic_cars(delta)


func spawn_traffic_car() -> void:
    if traffic_car_scene == null:
        return

    if traffic_cars.size() >= max_traffic_cars:
        return

    var car_instance: Node = traffic_car_scene.instantiate()

    if not car_instance is Node3D:
        car_instance.queue_free()
        return

    var car: Node3D = car_instance as Node3D
    add_child(car)

    var lane: float = randf_range(
        -road_width * 0.35,
        road_width * 0.35
    )

    car.position = Vector3(
        lane,
        0.0,
        -road_length * 0.5
    )

    traffic_cars.append(car)


func move_traffic_cars(delta: float) -> void:
    for car: Node3D in traffic_cars:
        if not is_instance_valid(car):
            continue

        var speed: float = traffic_speed_min

        car.position.z += speed * delta

        if car.position.z > road_length * 0.5:
            car.queue_free()


func clear_traffic() -> void:
    for car: Node3D in traffic_cars:
        if is_instance_valid(car):
            car.queue_free()

    traffic_cars.clear()
    spawn_timer = 0.0
