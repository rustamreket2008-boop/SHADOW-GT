
extends CanvasLayer

@export var car_path: NodePath = NodePath("../Car")

var car: Node
var speed_label: Label
var title_label: Label


func _ready() -> void:
    car = get_node_or_null(car_path)
    _create_hud()


func _process(_delta: float) -> void:
    if not is_instance_valid(car):
        return

    if not ("current_speed" in car):
        return

    var speed: float = absf(float(car.current_speed))
    speed_label.text = "%03d KM/H" % int(speed)


func _create_hud() -> void:
    var panel := PanelContainer.new()
    panel.position = Vector2(20, 20)
    panel.custom_minimum_size = Vector2(230, 100)
    add_child(panel)

    var layout := VBoxContainer.new()
    panel.add_child(layout)

    title_label = Label.new()
    title_label.text = "SHADOW GT"
    title_label.add_theme_font_size_override(
        "font_size", 24
    )
    title_label.add_theme_color_override(
        "font_color", Color(1.0, 0.78, 0.12)
    )
    layout.add_child(title_label)

    speed_label = Label.new()
    speed_label.text = "000 KM/H"
    speed_label.add_theme_font_size_override(
        "font_size", 30
    )
    layout.add_child(speed_label)
