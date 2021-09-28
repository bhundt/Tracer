//
//  Intersection.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

/// Description
class Intersection: Equatable {
    var t: Double     // the intersection along a ray
    var object: CollidableObject & IdentifiableObject  // the object the ray intersected with
    
    init(t: Double, obj: CollidableObject & IdentifiableObject) {
        self.object = obj
        self.t = t
    }
    
    func prepareComputation(ray: Ray) -> PrecomputeData {
        let i = self
        let t = i.t
        let obj = i.object
        
        let point = ray.position(t: t)
        let eyeVec = -ray.direction
        var normalVec = i.object.normal(at: point)
        var inside = false
        
        if normalVec.dot(withVector: eyeVec) < 0 {
            inside = true
            normalVec = -normalVec
        }
        
        let c = PrecomputeData(t: t, object: obj, point: point, eyeVec: eyeVec, normalVec: normalVec, inside: inside)
        return c
    }

    
    static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return (lhs.object.uniqueId == rhs.object.uniqueId) && (lhs.t == rhs.t)
    }
}

/// Holds pre computable info about an intersection
struct PrecomputeData {
    var t: Double
    var object: CollidableObject
    var point: Tuple
    var eyeVec: Tuple
    var normalVec: Tuple
    var inside: Bool
    
    init(t: Double, object: CollidableObject, point: Tuple, eyeVec: Tuple, normalVec: Tuple, inside: Bool) {
        self.t = t
        self.object = object
        self.point = point
        self.eyeVec = eyeVec
        self.normalVec = normalVec
        self.inside = inside
    }
}


extension Array where Element == Intersection {
    /// Sort the intetrsections by ascending t-value
    mutating func sort() {
        self.sort(by: { $0.t < $1.t })
    }
    
    
    /// Returns a sorted version of the intersections
    func sorted() -> Array {
        return self.sorted(by: { $0.t < $1.t })
    }
    
    /// Finds the nearest hit from the ray. Nearest means smallest, non-negative t-value
    func hit() -> Intersection? {
        let hits = self.sorted().filter({ elem in elem.t >= 0.0 })
        if hits.count > 0 {
            return hits.first
        }
        return nil
    }

}
