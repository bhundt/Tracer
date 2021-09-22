//
//  TupleProtocol.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

let COMPARE_EPSILON = 0.0001

protocol TupleProtocol: Equatable {
    init(x: Double, y: Double, z: Double, w: Double)
    
    var length: Double {get}
    
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
}

//func ==<T: TupleProtocol> (lhs: T, rhs: T) -> Bool {
//    return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z) && (lhs.w == rhs.w)
//}

func ==<T: TupleProtocol> (lhs: T, rhs: T) -> Bool {
    return (fabs(lhs.x - rhs.x) < COMPARE_EPSILON) &&
            (fabs(lhs.y - rhs.y) < COMPARE_EPSILON) &&
            (fabs(lhs.z - rhs.z) < COMPARE_EPSILON) &&
            (fabs(lhs.w - rhs.w) < COMPARE_EPSILON)
}

//func !~=<T: TupleProtocol> (lhs: T, rhs: T) -> Bool {
//    return !(lhs ~== rhs)
//}

func +<T: TupleProtocol> (lhs: T, rhs: T) -> T {
    return T(x: lhs.x+rhs.x, y: lhs.y+rhs.y, z: lhs.z+rhs.z, w: lhs.w+rhs.w)
}

func -<T: TupleProtocol> (lhs: T, rhs: T) -> T {
    return T(x: lhs.x-rhs.x, y: lhs.y-rhs.y, z: lhs.z-rhs.z, w: lhs.w-rhs.w)
}

func *<T: TupleProtocol> (lhs: T, rhs: Double) -> T {
    return T(x: lhs.x*rhs, y: lhs.y*rhs, z: lhs.z*rhs, w: lhs.w*rhs)
}

func *<T: TupleProtocol> (lhs: Double, rhs: T) -> T {
    return T(x: lhs*rhs.x, y: lhs*rhs.y, z: lhs*rhs.z, w: lhs*rhs.w)
}

func /<T: TupleProtocol> (lhs: T, rhs: Double) -> T {
    return T(x: lhs.x/rhs, y: lhs.y/rhs, z: lhs.z/rhs, w: lhs.w/rhs)
}

prefix func -<T: TupleProtocol> (op: T) -> T {
    return T(x: -op.x, y: -op.y, z: -op.z, w: -op.w)
}

