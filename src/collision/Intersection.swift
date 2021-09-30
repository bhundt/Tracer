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
    var object: CollidableObject & IdentifiableObject   // the object the ray intersected with
    
    init(t: Double, obj: CollidableObject & IdentifiableObject) {
        self.object = obj
        self.t = t
    }
    
    func prepareComputation(ray: Ray) -> ShadingHelperData {
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
    var object: CollidableObject
    var point: Tuple
    var eyeVec: Tuple
    var normalVec: Tuple
    var inside: Bool
    var overPoint: Tuple
    
    init(t: Double, object: CollidableObject, point: Tuple, eyeVec: Tuple, normalVec: Tuple, inside: Bool, overPoint: Tuple) {
        self.t = t
        self.object = object
        self.point = point
        self.eyeVec = eyeVec
        self.normalVec = normalVec
        self.inside = inside
        self.overPoint = overPoint
    }
}
