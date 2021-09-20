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

chapOnePlayground()
