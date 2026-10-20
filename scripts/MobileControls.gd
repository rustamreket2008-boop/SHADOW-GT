extends CanvasLayer

func _ready() -> void:
    _make_button("◀", "steer_left", 0.03, 0.78, 0.12, 0.93)
    _make_button("▶", "steer_right", 0.16, 0.78, 0.25, 0.93)
    _make_button("GAS", "accelerate", 0.77, 0.75, 0.96, 0.88)
    _make_button("BRAKE", "brake", 0.80, 0.89, 0.96, 0.99)


func _make_button(
    label_text: String,
    action_name: String,
    left_anchor: float,
    top_anchor: float,
    right_anchor: float,
    bottom_anchor: float
) -> void:
    var button := Button.new()
    button.text = label_text
    button.anchor_left = left_anchor
    button.anchor_top = top_anchor
    button.anchor_right = right_anchor
    button.anchor_bottom = bottom_anchor
    button.offset_left = 0
    button.offset_top = 0
    button.offset_right = 0
    button.offset_bottom = 0
    button.add_theme_font_size_override("font_size", 22)
    button.modulate = Color(1, 1, 1, 0.9)
    add_child(button)

    button.button_down.connect(
        _press_action.bind(action_name)
    )
    button.button_up.connect(
        _release_action.bind(action_name)
    )


func _press_action(action_name: String) -> void:
    Input.action_press(action_name)


func _release_action(action_name: String) -> void:
    Input.action_release(action_name)
