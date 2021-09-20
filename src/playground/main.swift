//
//  main.swift
//  Tracer
//
//  Created by Bastian Hundt on 19.09.21.
//

import Foundation

// p. 13
func chapOnePlayground() {
    var proj = Projectile(position: Tuple.makePoint(x: 0, y: 1, z: 0),
                          velocity: Tuple.makeVector(x: 1, y: 1, z: 0))
    let env = Environment(gravity: Tuple.makeVector(x: 0, y: -0.1, z: 0),
                          wind: Tuple.makeVector(x: -0.01, y: 0, z: 0))

    while proj.pos.y > 0 {
        proj = tick(environment: env, projectile: proj)
        print("Current Projectile Position: (\(proj.pos.x), \(proj.pos.y), \(proj.pos.z))")
    }
}

// p. 22
func chapTwoPlayground() {
    let canvas = Canvas(width: 1920, height: 1080)
    var proj = Projectile(position: Tuple.makePoint(x: 0, y: 1, z: 0),
                          velocity: Tuple.makeVector(x: 1, y: 1.5, z: 0).getNormalized() * 10)
    let env = Environment(gravity: Tuple.makeVector(x: 0, y: -0.1, z: 0),
                          wind: Tuple.makeVector(x: -0.01, y: 0, z: 0))

    while proj.pos.y > 0 {
        canvas[Int(proj.pos.x.rounded()), canvas.height - Int(proj.pos.y.rounded()) - 1] = Color(red: 1, green: 1, blue: 1)
        proj = tick(environment: env, projectile: proj)
        print("Current Projectile Position: (\(proj.pos.x), \(proj.pos.y), \(proj.pos.z))")
    }
    
    let ppm = canvas.toPortablePixMap()
    
    let path = FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0].appendingPathComponent("traj.ppm")
    
    do {
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {/* error handling here */}
}

chapTwoPlayground()
