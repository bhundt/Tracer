//
//  Ray.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

class Ray {
    var origin: Tuple
    var direction: Tuple
    
    init(origin: Tuple, direction: Tuple) {
        assert(origin.isPoint)
        assert(direction.isVector)
        
        self.origin = origin
        self.direction = direction
    }
    
    func position(t: Double) -> Tuple {
        return origin + direction * t
    }
    
    func transform(trafo: Matrix4) -> Ray {
        return Ray(origin: trafo * self.origin,
                   direction: trafo * self.direction)
    }
}
