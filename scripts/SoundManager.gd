extends Node
class_name SoundManager

var music_player: AudioStreamPlayer
var effects_player: AudioStreamPlayer
var engine_player: AudioStreamPlayer3D


func _ready() -> void:
    music_player = AudioStreamPlayer.new()
    music_player.name = "MusicPlayer"
    add_child(music_player)

    effects_player = AudioStreamPlayer.new()
    effects_player.name = "EffectsPlayer"
    add_child(effects_player)

    engine_player = AudioStreamPlayer3D.new()
    engine_player.name = "EnginePlayer"
    add_child(engine_player)


func play_music(stream: AudioStream, volume_db: float = -8.0) -> void:
    if stream == null:
        return

    music_player.stream = stream
    music_player.volume_db = volume_db
    music_player.play()


func play_effect(stream: AudioStream, volume_db: float = 0.0) -> void:
    if stream == null:
        return

    effects_player.stream = stream
    effects_player.volume_db = volume_db
    effects_player.play()


func play_engine(stream: AudioStream) -> void:
    if stream == null:
        return

    engine_player.stream = stream
    engine_player.play()


func stop_all_sounds() -> void:
    music_player.stop()
    effects_player.stop()
    engine_player.stop()


func set_music_volume(volume_db: float) -> void:
    music_player.volume_db = volume_db


func set_effects_volume(volume_db: float) -> void:
    effects_player.volume_db = volume_db
