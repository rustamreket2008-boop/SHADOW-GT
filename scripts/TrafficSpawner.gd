extends Node3D
class_name TrafficSpawner

@export var spawn_interval: float = 3.0
@export var spawn_distance: float = 100.0
@export var road_width: float = 9.0
@export var max_traffic: int = 8
@export var traffic_speed: float = 12.0

var spawn_timer: float = 0.0
var traffic_cars: Array[Node3D] = []
var running: bool = false


func start_spawning() -> void:
    running = true
    spawn_timer = 0.0


func stop_spawning() -> void:
    running = false


func _process(delta: float) -> void:
    if not running:
        return

    spawn_timer += delta

    if spawn_timer >= spawn_interval:
        spawn_timer = 0.0
        _spawn_car()

    _remove_invalid_cars()


func _spawn_car() -> void:
    if traffic_cars.size() >= max_traffic:
        return

    var car := Node3D.new()
    car.name = "TrafficCar"

    var body := MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = Vector3(1.8, 1.0, 3.8)
    body.mesh = mesh

    var material := StandardMaterial3D.new()
    material.albedo_color = Color(
        randf_range(0.1, 0.9),
        randf_range(0.1, 0.9),
        randf_range(0.1, 0.9)
    )
    body.material_override = material
    body.position.y = 0.7
    car.add_child(body)

    var lane := randf_range(
        -road_width * 0.35,
        road_width * 0.35
    )

    car.position = Vector3(
        lane,
        0.0,
        -spawn_distance
    )

    add_child(car)
    traffic_cars.append(car)


func _remove_invalid_cars() -> void:
    for car in traffic_cars.duplicate():
        if not is_instance_valid(car):
            traffic_cars.erase(car)
