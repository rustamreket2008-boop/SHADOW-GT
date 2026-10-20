extends CanvasLayer
class_name PauseManager

signal pause_changed(is_paused: bool)

var pause_panel: PanelContainer
var is_paused: bool = false


func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    _create_pause_button()
    _create_pause_panel()


func _create_pause_button() -> void:
    var button := Button.new()
    button.name = "PauseButton"
    button.text = "Ⅱ"
    button.position = Vector2(20, 130)
    button.custom_minimum_size = Vector2(70, 60)
    button.add_theme_font_size_override("font_size", 28)
    add_child(button)
    button.pressed.connect(toggle_pause)


func _create_pause_panel() -> void:
    pause_panel = PanelContainer.new()
    pause_panel.name = "PausePanel"
    pause_panel.set_anchors_and_offsets_preset(
        Control.PRESET_CENTER
    )
    pause_panel.custom_minimum_size = Vector2(280, 220)
    add_child(pause_panel)

    var layout := VBoxContainer.new()
    pause_panel.add_child(layout)

    var title := Label.new()
    title.text = "SHADOW GT"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    layout.add_child(title)

    var resume_button := Button.new()
    resume_button.text = "Давом додан"
    layout.add_child(resume_button)
    resume_button.pressed.connect(resume_game)

    var restart_button := Button.new()
    restart_button.text = "Аз нав оғоз"
    layout.add_child(restart_button)
    restart_button.pressed.connect(restart_game)

    pause_panel.hide()


func toggle_pause() -> void:
    if is_paused:
        resume_game()
    else:
        pause_game()


func pause_game() -> void:
    is_paused = true
    get_tree().paused = true
    pause_panel.show()
    pause_changed.emit(true)


func resume_game() -> void:
    is_paused = false
    get_tree().paused = false
    pause_panel.hide()
    pause_changed.emit(false)


func restart_game() -> void:
    get_tree().paused = false
    get_tree().reload_current_scene()
