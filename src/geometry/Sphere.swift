//
//  Sphere.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

class Sphere: CollidableObject, IdentifiableObject, ShadeableObject, Equatable {
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
    
    func normal(at: Tuple) -> Tuple {
        let objectPoint = transform.inversed * at
        let objectNormal = objectPoint - Tuple.makePoint(x: 0, y: 0, z: 0)
        var worldNormal = transform.inversed.transposed * objectNormal
        worldNormal.w = 0.0
        return worldNormal.normalized
    }
    
    static func == (lhs: Sphere, rhs: Sphere) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
