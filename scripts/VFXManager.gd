extends Node3D
class_name VFXManager


func create_nitro_effect(parent_node: Node3D) -> void:
    if not is_instance_valid(parent_node):
        return

    var particles := GPUParticles3D.new()
    particles.name = "NitroParticles"
    particles.amount = 40
    particles.lifetime = 0.45
    particles.explosiveness = 0.0
    particles.emitting = true

    var mesh := SphereMesh.new()
    mesh.radius = 0.12
    mesh.height = 0.24

    var material := StandardMaterial3D.new()
    material.albedo_color = Color(0.1, 0.65, 1.0)
    material.emission_enabled = true
    material.emission = Color(0.1, 0.65, 1.0)
    mesh.material = material

    particles.draw_pass_1 = mesh

    var process_material := ParticleProcessMaterial.new()
    process_material.direction = Vector3(0.0, 0.0, 1.0)
    process_material.spread = 18.0
    process_material.initial_velocity_min = 3.0
    process_material.initial_velocity_max = 7.0
    process_material.gravity = Vector3.ZERO
    process_material.scale_min = 0.3
    process_material.scale_max = 1.0
    particles.process_material = process_material

    parent_node.add_child(particles)
    particles.position = Vector3(0.0, 0.4, 1.8)


func create_crash_effect(
    parent_node: Node3D,
    effect_position: Vector3
) -> void:
    if not is_instance_valid(parent_node):
        return

    var particles := GPUParticles3D.new()
    particles.name = "CrashParticles"
    particles.amount = 50
    particles.lifetime = 0.7
    particles.one_shot = true
    particles.explosiveness = 1.0

    var mesh := SphereMesh.new()
    mesh.radius = 0.08
    mesh.height = 0.16

    var material := StandardMaterial3D.new()
    material.albedo_color = Color(1.0, 0.55, 0.08)
    material.emission_enabled = true
    material.emission = Color(1.0, 0.3, 0.02)
    mesh.material = material

    particles.draw_pass_1 = mesh

    var process_material := ParticleProcessMaterial.new()
    process_material.direction = Vector3.UP
    process_material.spread = 180.0
    process_material.initial_velocity_min = 2.0
    process_material.initial_velocity_max = 8.0
    process_material.gravity = Vector3(0.0, -9.8, 0.0)
    particles.process_material = process_material

    parent_node.add_child(particles)
    particles.global_position = effect_position
    particles.emitting = true
