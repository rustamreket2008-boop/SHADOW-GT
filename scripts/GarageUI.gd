extends CanvasLayer
class_name GarageUI

signal car_selection_requested(car_id: String)
signal garage_closed

var garage_panel: PanelContainer
var car_list: VBoxContainer

var cars: Array[Dictionary] = [
    {"id": "starter", "name": "STARTER GT", "price": 0},
    {"id": "sport_red", "name": "SPORT RED", "price": 2500},
    {"id": "sport_blue", "name": "SPORT BLUE", "price": 3000},
    {"id": "street", "name": "STREET X", "price": 4500},
    {"id": "racing", "name": "RACING PRO", "price": 8000},
    {"id": "police", "name": "POLICE GT", "price": 10000},
    {"id": "supercar", "name": "SUPERCAR", "price": 12000},
    {"id": "black_gt", "name": "BLACK GT", "price": 15000},
    {"id": "neon", "name": "NEON X", "price": 20000}
]


func _ready() -> void:
    _build_garage()


func _build_garage() -> void:
    garage_panel = PanelContainer.new()
    garage_panel.set_anchors_preset(Control.PRESET_CENTER)
    garage_panel.position = Vector2(-220, -280)
    garage_panel.custom_minimum_size = Vector2(440, 560)
    add_child(garage_panel)

    var layout := VBoxContainer.new()
    garage_panel.add_child(layout)

    var title := Label.new()
    title.text = "SHADOW GT — GARAGE"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title.add_theme_font_size_override("font_size", 26)
    layout.add_child(title)

    var scroll := ScrollContainer.new()
    scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
    layout.add_child(scroll)

    car_list = VBoxContainer.new()
    car_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    scroll.add_child(car_list)

    for car_data in cars:
        var button := Button.new()
        button.text = "%s — %d $" % [
            car_data["name"],
            car_data["price"]
        ]
        button.custom_minimum_size.y = 48
        button.pressed.connect(
            _select_car.bind(str(car_data["id"]))
        )
        car_list.add_child(button)

    var close_button := Button.new()
    close_button.text = "БАСТАН"
    close_button.custom_minimum_size.y = 48
    close_button.pressed.connect(_close_garage)
    layout.add_child(close_button)


func _select_car(car_id: String) -> void:
    car_selection_requested.emit(car_id)


func _close_garage() -> void:
    garage_closed.emit()
    queue_free()
