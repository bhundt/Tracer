//
//  Plane.swift
//  Tracer
//
//  Created by Bastian Hundt on 03.10.21.
//

import Foundation

class Plane: Shape, Equatable {
    private var _id: UUID = UUID()
    var uniqueId: UUID { get{ return _id } }
    
    var transform: Matrix4 = Matrix4.makeIdentity()
    var material: Material = Material()
    
    init() {}
    
    init(trafo: Matrix4) {
        transform = trafo
    }
    
    func localIntersect(withRay ray: Ray) -> [Intersection] {
        if fabs(ray.direction.y) < COMPARE_EPSILON {
            return []
        }
        let t = -ray.origin.y / ray.direction.y
        return [Intersection(t: t, obj: self)]
    }
    
    func localNormal(atPoint point: Tuple) -> Tuple {
        return Tuple.makeVector(x: 0, y: 1, z: 0)
    }
    
    static func == (lhs: Plane, rhs: Plane) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
