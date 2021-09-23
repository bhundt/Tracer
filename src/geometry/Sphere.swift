//
//  Sphere.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

class Sphere: IdentifiableObject, Equatable {
    private var _id: UUID
    private var _trafo: Matrix = Matrix.makeIdentity(size: 4)
    var uniqueId: UUID { get{ return _id } }
    var transform: Matrix {
        get {
            return _trafo
        }
        set(t) {
            assert(t.rows == 4 && t.columns == 4)
            _trafo = t
        }
    }
    
    init() {
        _id = UUID()
    }
    
    init(trafo: Matrix) {
        _id = UUID()
        transform = trafo
    }
    
    static func == (lhs: Sphere, rhs: Sphere) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
