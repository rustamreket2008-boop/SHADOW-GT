extends Node
class_name AudioManager

var engine_player: AudioStreamPlayer
var effects_player: AudioStreamPlayer

var engine_sound: AudioStream
var brake_sound: AudioStream
var nitro_sound: AudioStream
var crash_sound: AudioStream

var target_pitch: float = 0.8
var target_volume: float = -18.0


func _ready() -> void:
    engine_player = AudioStreamPlayer.new()
    engine_player.name = "EngineAudio"
    engine_player.volume_db = -18.0
    add_child(engine_player)

    effects_player = AudioStreamPlayer.new()
    effects_player.name = "EffectsAudio"
    add_child(effects_player)


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

    engine_player.stream = engine_sound
    engine_player.volume_db = -18.0

    if engine_sound != null:
        engine_player.play()


func update_engine_sound(throttle: float) -> void:
    if not is_instance_valid(engine_player):
        return

    if engine_player.stream == null:
        return

    var power: float = clampf(throttle, 0.0, 1.0)

    target_pitch = lerpf(0.8, 1.8, power)
    target_volume = lerpf(-18.0, -3.0, power)

    if not engine_player.playing:
        engine_player.play()

    engine_player.pitch_scale = lerpf(
        engine_player.pitch_scale,
        target_pitch,
        0.15
    )

    engine_player.volume_db = lerpf(
        engine_player.volume_db,
        target_volume,
        0.15
    )


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
        return

    effects_player.stream = sound
    effects_player.play()
