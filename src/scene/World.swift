//
//  World.swift
//  Tracer
//
//  Created by Bastian Hundt on 28.09.21.
//

import Foundation

/// This protocol represents any object in the world which needs to be uniquely identified
protocol IdentifiableObject {
    var uniqueId: UUID { get }
}


class World {
    var objects: [IdentifiableObject & Shape] = []
    var lights: [IdentifiableObject] = []
    
    func intersect(withRay ray: Ray) -> [Intersection] {
        var intersections: [Intersection] = []
        for obj in objects {
            intersections.append(contentsOf: obj.intersect(withRay: ray))
        }
        
        // only sort when we have more than one intersection since sorted is rather expensive
        if intersections.count > 1 {
            intersections.sort()
        }
        return intersections
    }
    
    static func makeDefaultWorld() -> World {
        let w = World()
        let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        var s1 = Sphere()
        s1.material.color = Color(red: 0.8, green: 1.0, blue: 0.6)
        s1.material.diffuse = 0.7
        s1.material.specular = 0.2
        
        let s2 = Sphere(trafo: Matrix4.makeIdentity().scale(x: 0.5, y: 0.5, z: 0.5))
        
        w.lights.append(light)
        w.objects.append(s1)
        w.objects.append(s2)
        return w
    }
}
