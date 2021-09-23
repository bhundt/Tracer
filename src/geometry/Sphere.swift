//
//  Sphere.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

class Sphere: IdentifiableObject, Equatable {
    private var _id: UUID
    private var _trafo: Matrix4 = Matrix4.makeIdentity()
    var uniqueId: UUID { get{ return _id } }
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
    
    static func == (lhs: Sphere, rhs: Sphere) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
