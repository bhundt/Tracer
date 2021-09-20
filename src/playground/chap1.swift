//
//  chap1.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

class Projectile {
    var pos: Tuple
    var velocity: Tuple
    
    init() {
        pos = Tuple.makePoint(x: 0, y: 0, z: 0)
        velocity = Tuple.makeVector(x: 0, y: 0, z: 0)
    }
    
    init(position: Tuple, velocity: Tuple) {
        pos = position
        self.velocity = velocity
    }
}

class Environment {
    var gravity: Tuple
    var wind: Tuple
    
    init() {
        gravity = Tuple.makeVector(x: 0, y: 0, z: 0)
        wind = Tuple.makeVector(x: 0, y: 0, z: 0)
    }
    
    init(gravity: Tuple, wind: Tuple) {
        self.gravity = gravity
        self.wind = wind
    }
}

func tick(environment: Environment, projectile: Projectile) -> Projectile {
    let newPosition = projectile.pos + projectile.velocity
    let newVelocity = projectile.velocity + environment.gravity + environment.wind
    return Projectile(position: newPosition, velocity: newVelocity)
}
