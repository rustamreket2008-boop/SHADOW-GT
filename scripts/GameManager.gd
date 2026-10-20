
extends Node

signal game_started
signal game_paused
signal game_resumed
signal game_restarted

enum GameState {
    MENU,
    PLAYING,
    PAUSED,
    GAME_OVER
}

var state: GameState = GameState.MENU


func start_game() -> void:
    if state == GameState.PLAYING:
        return

    state = GameState.PLAYING
    get_tree().paused = false
    game_started.emit()


func pause_game() -> void:
    if state != GameState.PLAYING:
        return

    state = GameState.PAUSED
    get_tree().paused = true
    game_paused.emit()


func resume_game() -> void:
    if state != GameState.PAUSED:
        return

    get_tree().paused = false
    state = GameState.PLAYING
    game_resumed.emit()


func restart_game() -> void:
    get_tree().paused = false
    state = GameState.PLAYING
    game_restarted.emit()
    get_tree().reload_current_scene()


func end_game() -> void:
    get_tree().paused = false
    state = GameState.GAME_OVER
