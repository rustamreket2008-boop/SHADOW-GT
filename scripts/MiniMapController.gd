
extends Control
class_name MiniMapController

@export var player: Node3D
@export var map_scale: float = 2.0

var marker: ColorRect
var direction_marker: Polygon2D


func _ready() -> void:
    custom_minimum_size = Vector2(180, 180)
    clip_contents = true

    var background := ColorRect.new()
    background.color = Color(0.02, 0.04, 0.07, 0.85)
    background.set_anchors_and_offsets_preset(
        Control.PRESET_FULL_RECT
    )
    add_child(background)

    marker = ColorRect.new()
    marker.color = Color(1.0, 0.78, 0.12)
    marker.size = Vector2(10, 10)
    add_child(marker)

    direction_marker = Polygon2D.new()
    direction_marker.polygon = PackedVector2Array([
        Vector2(0, -8),
        Vector2(-5, 5),
        Vector2(5, 5)
    ])
    direction_marker.color = Color(0.1, 0.8, 1.0)
    add_child(direction_marker)


func _process(_delta: float) -> void:
    if not is_instance_valid(player):
        return

    var center := size * 0.5
    marker.position = center - marker.size * 0.5
    direction_marker.position = center

    direction_marker.rotation = -player.global_rotation.y


func set_player(target: Node3D) -> void:
    player = target


func set_map_scale(value: float) -> void:
    map_scale = clampf(value, 0.5, 10.0)
