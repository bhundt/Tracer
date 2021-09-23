//
//  Matrix4.swift
//  Tracer
//
//  Created by Bastian Hundt on 23.09.21.
//

import Foundation
import simd

struct Matrix4: Equatable {
    var m: simd_double4x4 = simd_double4x4(0.0)
    
    init() {
        
    }
    
    init(nativeMatrix: simd_double4x4) {
        m = nativeMatrix
    }
    
    static func makeIdentity() -> Matrix4 {
        var newMatrix = Matrix4()
        newMatrix.m = matrix_identity_double4x4
        return newMatrix
    }
    
    subscript(row: Int, col: Int) -> Double {
        get {
            assert(row >= 0); assert(col >= 0); assert(row < 4); assert(col < 4)
            return m[row][col]
        }
        set(val) {
            assert(row >= 0); assert(col >= 0); assert(row < 4); assert(col < 4)
            m[row][col] = val
        }
    }
    
    var transposed: Matrix4 {
        get {
            return Matrix4(nativeMatrix: self.m.transpose)
        }
        
    }
    
    var inversed: Matrix4 {
        get {
            return Matrix4(nativeMatrix: self.m.inverse)
        }
    }
    
    var invertible: Bool {
        get {
            return !(m.determinant == 0)
        }
    }
    
    var determinant: Double {
        get {
            return m.determinant
        }
    }
    
    static func makeTranslation(x: Double, y: Double, z: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[0, 3] = x
        trafo[1, 3] = y
        trafo[2, 3] = z
        return trafo
    }
    
    func translate(x: Double, y: Double, z: Double) -> Matrix4 {
        return  Matrix4.makeTranslation(x: x, y: y, z: z) * self
    }
    
    static func makeScaling(x: Double, y: Double, z: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[0, 0] = x
        trafo[1, 1] = y
        trafo[2, 2] = z
        return trafo
    }
    
    func scale(x: Double, y: Double, z: Double) -> Matrix4 {
        return Matrix4.makeScaling(x: x, y: y, z: z) * self
    }
    
    static func makeRotationX(radians: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[1, 1] = cos(radians); trafo[1, 2] = -sin(radians)
        trafo[2, 1] = sin(radians); trafo[2, 2] = cos(radians)
        return trafo
    }
    
    func rotateX(radians: Double) -> Matrix4 {
        return Matrix4.makeRotationX(radians: radians) * self
    }
    
    static func makeRotationY(radians: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[0, 0] = cos(radians); trafo[0, 2] = sin(radians)
        trafo[2, 0] = -sin(radians); trafo[2, 2] = cos(radians)
        return trafo
    }
    
    func rotateY(radians: Double) -> Matrix4 {
        return Matrix4.makeRotationY(radians: radians) * self
    }
    
    static func makeRotationZ(radians: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[0, 0] = cos(radians); trafo[0, 1] = -sin(radians)
        trafo[1, 0] = sin(radians); trafo[1, 1] = cos(radians)
        return trafo
    }
    
    func rotateZ(radians: Double) -> Matrix4 {
        return Matrix4.makeRotationZ(radians: radians) * self
    }
    
    static func makeShear(xy: Double, xz: Double, yx: Double, yz: Double, zx: Double, zy: Double) -> Matrix4 {
        var trafo = makeIdentity()
        trafo[0, 1] = xy; trafo[0, 2] = xz
        trafo[1, 0] = yx; trafo[1, 2] = yz
        trafo[2, 0] = zx; trafo[2, 1] = zy
        return trafo
    }
    
    static func * (lhs: Matrix4, rhs: Matrix4) -> Matrix4 {
        return Matrix4(nativeMatrix: matrix_multiply(rhs.m, lhs.m))
    }
    
    static func == (lhs: Matrix4, rhs: Matrix4) -> Bool {
        return simd_almost_equal_elements(lhs.m, rhs.m, COMPARE_EPSILON)
    }
    
    static func != (lhs: Matrix4, rhs: Matrix4) -> Bool {
        return !(lhs == rhs)
    }
}

/// Multiplies a 4-component Tuple with a Matrix
/// - Parameters:
///   - lhs: The Matrix
///   - rhs: The Tuple
/// - Returns: The resulting Tuple
func *<T: TupleProtocol> (lhs: Matrix4, rhs: T) -> T {
    let vec = simd_double4(rhs.x, rhs.y, rhs.z, rhs.w)
    //let R = lhs.m * vec
    let R = matrix_multiply(vec, lhs.m)
    
    return T(x: R[0], y: R[1], z: R[2], w: R[3])
}
