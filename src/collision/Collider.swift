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
            intersections.append(contentsOf: obj.intersect(withRay: ray))
        }
        return intersections.sorted()
    }
}


