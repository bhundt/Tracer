//
//  TupleProtocol.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

protocol TupleProtocol: Equatable {
    var x: Double {get set}
    var y: Double {get set}
    var z: Double {get set}
    var w: Double {get set}
}

extension TupleProtocol {
    var length: Double {
        get {
            return (x*x + y*y + z*z + w*w).squareRoot()
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z) && (lhs.w == rhs.w)
    }
    
    static func + (lhs: Self, rhs: Self) -> Tuple {
        return Tuple(x: lhs.x+rhs.x, y: lhs.y+rhs.y, z: lhs.z+rhs.z, w: lhs.w+rhs.w)
    }
    
    static func - (lhs: Self, rhs: Self) -> Tuple {
        return Tuple(x: lhs.x-rhs.x, y: lhs.y-rhs.y, z: lhs.z-rhs.z, w: lhs.w-rhs.w)
    }
    
    static func * (lhs: Self, rhs: Double) -> Tuple {
        return Tuple(x: lhs.x*rhs, y: lhs.y*rhs, z: lhs.z*rhs, w: lhs.w*rhs)
    }
    
    static func * (lhs: Double, rhs: Self) -> Tuple {
        return Tuple(x: lhs*rhs.x, y: lhs*rhs.y, z: lhs*rhs.z, w: lhs*rhs.w)
    }
    
    static func / (lhs: Self, rhs: Double) -> Tuple {
        return Tuple(x: lhs.x/rhs, y: lhs.y/rhs, z: lhs.z/rhs, w: lhs.w/rhs)
    }
    
    static prefix func - (op: Self) -> Tuple {
        return Tuple(x: -op.x, y: -op.y, z: -op.z, w: -op.w)
    }
}
