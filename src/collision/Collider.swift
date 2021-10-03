//
//  Collider.swift
//  Tracer
//
//  Created by Bastian Hundt on 29.09.21.
//

import Foundation

class Collider {
    static func intersect(ray: Ray, withWorld world: World) -> [Intersection] {
        var intersections: [Intersection] = []
        for obj in world.objects {
            switch obj {
                case let sphere as Sphere:
                intersections.append(contentsOf: sphere.intersect(withRay: ray))
                    //let (i1, i2) = self.intersect(ray: ray, withSphere: sphere)
                    //if let int1 = i1 { intersections.append(int1) }
                    //if let int2 = i2 { intersections.append(int2) }
                default:
                    break
            }
        }
        return intersections.sorted()
    }
}


