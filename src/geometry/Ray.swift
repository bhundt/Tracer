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
    
    func intersect(sphere: Sphere) -> [Intersection] {
        let ray2 = self.transform(trafo: sphere.transform.inversed) // we transform back to a unit sphere centered at 0,0,0
        
        let sphereToRay = ray2.origin - Tuple.makePoint(x: 0, y: 0, z: 0)
        let a = ray2.direction.dot(withVector: ray2.direction)
        let b = 2 * ray2.direction.dot(withVector: sphereToRay)
        let c = sphereToRay.dot(withVector: sphereToRay) - 1
        let dsc = pow(b, 2.0) - 4 * a * c
        
        if dsc < 0 {
            return []
        }
        
        let t1 = (-b - dsc.squareRoot()) / (2 * a)
        let t2 = (-b + dsc.squareRoot()) / (2 * a)
        
        return [Intersection(t: t1, obj: sphere), Intersection(t: t2, obj: sphere)]
    }
    
    func intersect(world: World) -> [Intersection] {
        var intersections: [Intersection] = []
        for obj in world.objects {
            switch obj {
            case is Sphere:
                intersections.append(contentsOf: self.intersect(sphere: obj as! Sphere))
            default: break
            }
        }
        return intersections.sorted()
    }
    
    func transform(trafo: Matrix4) -> Ray {
        return Ray(origin: trafo * self.origin,
                   direction: trafo * self.direction)
    }
}
