extends Node3D
class_name RoadBuilder

@export var road_length: float = 300.0
@export var road_width: float = 14.0
@export var segment_length: float = 10.0

func _ready() -> void:
    build_road()


func build_road() -> void:
    var road_material := StandardMaterial3D.new()
    road_material.albedo_color = Color(0.09, 0.10, 0.12)
    road_material.roughness = 0.95

    var road := MeshInstance3D.new()
    road.name = "RaceRoad"

    var road_mesh := BoxMesh.new()
    road_mesh.size = Vector3(road_width, 0.2, road_length)
    road.mesh = road_mesh
    road.material_override = road_material
    road.position = Vector3(0, -0.15, -road_length / 2.0)
    add_child(road)

    _add_line("LeftEdge", -road_width / 2.0 + 0.2)
    _add_line("RightEdge", road_width / 2.0 - 0.2)
    _add_center_marks()


func _add_line(line_name: String, x_pos: float) -> void:
    var line := MeshInstance3D.new()
    line.name = line_name

    var mesh := BoxMesh.new()
    mesh.size = Vector3(0.12, 0.025, road_length)
    line.mesh = mesh

    var mat := StandardMaterial3D.new()
    mat.albedo_color = Color(1.0, 0.82, 0.15)
    line.material_override = mat
    line.position = Vector3(x_pos, -0.035, -road_length / 2.0)
    add_child(line)


func _add_center_marks() -> void:
    var mat := StandardMaterial3D.new()
    mat.albedo_color = Color(0.95, 0.95, 0.95)

    var count := int(road_length / segment_length)

    for i in range(count):
        var mark := MeshInstance3D.new()
        mark.name = "CenterMark_%d" % i

        var mesh := BoxMesh.new()
        mesh.size = Vector3(0.12, 0.03, segment_length * 0.5)
        mark.mesh = mesh
        mark.material_override = mat
        mark.position = Vector3(
            0,
            -0.025,
            -i * segment_length - segment_length * 0.5
        )
        add_child(mark)
