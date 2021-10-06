//
//  Benchmark.swift
//  Tracer
//
//  Created by Bastian Hundt on 06.10.21.
//

import Foundation

/// on M1 macbook takes 1.4s when using 6 render chunks
func benchmarkRender() {
    var floor = Plane()
    floor.material.color = Color(red: 0.9, green: 0.9, blue: 0.9)
    floor.material.specular = 0
    floor.material.ambient = 0.2
    
    var middle = Sphere()
    middle.transform = Matrix4.makeTranslation(x: -0.5, y: 1, z: 0.5)
    middle.material.color = Color(red: 0.1, green: 1, blue: 0.5)
    middle.material.diffuse = 0.7
    middle.material.specular = 0.3
    middle.material.pattern = StripePattern(color1: Color(red: 0.1, green: 0.8, blue: 0.1), color2: Color(red: 0.05, green: 0.4, blue: 0.05))
    
    var right = Sphere()
    right.transform = Matrix4.makeTranslation(x: 1.5, y: 0.5, z: -0.5) * Matrix4.makeScaling(x: 0.5, y: 0.5, z: 0.5)
    right.material.color = Color(red: 0.5, green: 1, blue: 0.1)
    right.material.diffuse = 0.7
    right.material.specular = 0.3
    
    var left = Sphere()
    left.transform = Matrix4.makeTranslation(x: -1.5, y: 0.33, z: -0.75) * Matrix4.makeScaling(x: 0.33, y: 0.33, z: 0.33)
    left.material.color = Color(red: 1, green: 0.8, blue: 0.1)
    left.material.diffuse = 0.7
    left.material.specular = 0.3
    
    let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
    
    let camera = Camera(horizontalSize: 480*2, verticalSize: 270*2, fov: Double.pi/3)
    camera.transform = Matrix4.makeviewTransform(from: Tuple.makePoint(x: 0, y: 1.5, z: -5), to: Tuple.makePoint(x: 0, y: 1, z: 0), up: Tuple.makeVector(x: 0, y: 1, z: 0))//.rotateY(radians: Double.pi/32)
    
    let w = World()
    w.objects.append(contentsOf: [middle, left, right])
    w.objects.append(floor)
    w.lights.append(light)
    
    let canvas = Renderer.render(camera: camera, world: w)
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("scene_plane_pat.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}
