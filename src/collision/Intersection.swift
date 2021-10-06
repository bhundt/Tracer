//
//  Intersection.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

/// An intersection represents a collision of a ray with a geometric shape
struct Intersection: Equatable {
    var t: Double                                       // the intersection along the ray
    var object: Shape                                  // the object the ray intersected with
    
    init(t: Double, obj: Shape) {
        self.object = obj
        self.t = t
    }
    
    func prepareComputation(ray: Ray) -> ShadingHelperData {
        let i = self
        let t = i.t
        let obj = i.object
        
        let point = ray.position(t: t)
        let eyeVec = -ray.direction
        var normalVec = i.object.normalVec(atPoint: point)
        var inside = false
        
        if normalVec.dot(withVector: eyeVec) < 0 {
            inside = true
            normalVec = -normalVec
        }
        
        let oP = point + normalVec * COMPARE_EPSILON
        
        let c = ShadingHelperData(t: t, object: obj, point: point, eyeVec: eyeVec, normalVec: normalVec, inside: inside, overPoint: oP)
        return c
    }

    
    static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return (lhs.object.uniqueId == rhs.object.uniqueId) && (lhs.t == rhs.t)
    }
}

/// Holds pre computable info about an intersection
struct ShadingHelperData {
    var t: Double
    var object: Shape
    var point: Tuple
    var eyeVec: Tuple
    var normalVec: Tuple
    var inside: Bool
    var overPoint: Tuple
    
    init(t: Double, object: Shape, point: Tuple, eyeVec: Tuple, normalVec: Tuple, inside: Bool, overPoint: Tuple) {
        self.t = t
        self.object = object
        self.point = point
        self.eyeVec = eyeVec
        self.normalVec = normalVec
        self.inside = inside
        self.overPoint = overPoint
    }
}

/// These extension help using an array of intersections
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
        let hits = self.filter({ elem in elem.t >= 0.0 })
        return hits.min(by: { (a,b) -> Bool in
            return a.t < b.t
        })
    }

}
