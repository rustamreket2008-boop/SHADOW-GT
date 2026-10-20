extends CanvasLayer
class_name MenuManager

signal play_requested
signal garage_requested
signal settings_requested
signal exit_requested

var menu_panel: PanelContainer


func _ready() -> void:
    _create_menu()


func _create_menu() -> void:
    menu_panel = PanelContainer.new()
    menu_panel.set_anchors_preset(Control.PRESET_CENTER)
    menu_panel.position = Vector2(-180, -190)
    menu_panel.custom_minimum_size = Vector2(360, 380)
    add_child(menu_panel)

    var layout := VBoxContainer.new()
    layout.add_theme_constant_override("separation", 16)
    menu_panel.add_child(layout)

    var title := Label.new()
    title.text = "SHADOW GT"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title.add_theme_font_size_override("font_size", 34)
    title.add_theme_color_override(
        "font_color",
        Color(1.0, 0.75, 0.1)
    )
    layout.add_child(title)

    _add_button(layout, "🏁 БОЗӢ", _on_play)
    _add_button(layout, "🚘 ГАРАЖ", _on_garage)
    _add_button(layout, "⚙ ТАНЗИМОТ", _on_settings)
    _add_button(layout, "✖ БАРОМАД", _on_exit)


func _add_button(
    parent: VBoxContainer,
    button_text: String,
    callback: Callable
) -> void:
    var button := Button.new()
    button.text = button_text
    button.custom_minimum_size = Vector2(300, 55)
    button.add_theme_font_size_override("font_size", 20)
    button.pressed.connect(callback)
    parent.add_child(button)


func _on_play() -> void:
    play_requested.emit()


func _on_garage() -> void:
    garage_requested.emit()


func _on_settings() -> void:
    settings_requested.emit()


func _on_exit() -> void:
    exit_requested.emit()
