
extends Node
class_name AudioManager

var engine_player: AudioStreamPlayer
var effects_player: AudioStreamPlayer

var engine_sound: AudioStream
var brake_sound: AudioStream
var nitro_sound: AudioStream
var crash_sound: AudioStream


func setup_audio(
    engine: AudioStream,
    brake: AudioStream,
    nitro: AudioStream,
    crash: AudioStream
) -> void:
    engine_sound = engine
    brake_sound = brake
    nitro_sound = nitro
    crash_sound = crash

    if engine_player == null:
        engine_player = AudioStreamPlayer.new()
        engine_player.name = "EngineAudio"
        add_child(engine_player)

    if effects_player == null:
        effects_player = AudioStreamPlayer.new()
        effects_player.name = "EffectsAudio"
        add_child(effects_player)

    engine_player.stream = engine_sound


func update_engine_sound(speed_ratio: float) -> void:
    if not is_instance_valid(engine_player):
        return

    if engine_player.stream == null:
        return

    if not engine_player.playing:
        engine_player.play()

    engine_player.pitch_scale = lerpf(
        0.8,
        1.8,
        clampf(speed_ratio, 0.0, 1.0)
    )

    engine_player.volume_db = -8.0


func play_brake() -> void:
    _play_effect(brake_sound)


func play_nitro() -> void:
    _play_effect(nitro_sound)


func play_crash() -> void:
    _play_effect(crash_sound)


func stop_engine() -> void:
    if is_instance_valid(engine_player):
        engine_player.stop()


func _play_effect(sound: AudioStream) -> void:
    if sound == null:
        return

    if not is_instance_valid(effects_player):
        effects_player = AudioStreamPlayer.new()
        effects_player.name = "EffectsAudio"
        add_child(effects_player)

    effects_player.stream = sound
    effects_player.play()
