//
//  Sphere.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

class Sphere: Shape, IdentifiableObject, Equatable {
    private var _id: UUID
    var uniqueId: UUID { get{ return _id } }
    
    private var _trafo: Matrix4 = Matrix4.makeIdentity()
    var material: Material = Material()
   
    var transform: Matrix4 {
        get {
            return _trafo
        }
        set(t) {
            _trafo = t
        }
    }
    
    init() {
        _id = UUID()
    }
    
    init(trafo: Matrix4) {
        _id = UUID()
        transform = trafo
    }
    
    func localIntersect(withRay ray: Ray) -> [Intersection] {
        let sphereToRay = ray.origin - Tuple.makePoint(x: 0, y: 0, z: 0)
        let a = ray.direction.dot(withVector: ray.direction)
        let b = 2 * ray.direction.dot(withVector: sphereToRay)
        let c = sphereToRay.dot(withVector: sphereToRay) - 1
        let dsc = pow(b, 2.0) - 4 * a * c
        
        if dsc < 0 {
            return []
        }
        
        let t1 = (-b - dsc.squareRoot()) / (2 * a)
        let t2 = (-b + dsc.squareRoot()) / (2 * a)
        
        return [Intersection(t: t1, obj: self), Intersection(t: t2, obj: self)]
    }
    
    func localNormal(atPoint point: Tuple) -> Tuple {
        var objectNormal = point - Tuple.makePoint(x: 0, y: 0, z: 0)
        objectNormal.w = 0
        return objectNormal.normalized
    }
    
    static func == (lhs: Sphere, rhs: Sphere) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
