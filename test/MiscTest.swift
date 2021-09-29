//
//  MiscTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 23.09.21.
//

import XCTest
import simd

class MiscTest: XCTestCase {

    /*func testMatInverseSIMD() throws {
        self.measure {
            for _ in 0..<100 {
                let mat = matrix_identity_double4x4
                let i = mat.inverse
                XCTAssert(i != nil)
            }
        }
    }
    
    func testMatInverseOwn() throws {
        self.measure {
            for _ in 0..<100 {
                let mat = Matrix.makeIdentity(size: 4)
                let i = mat.inversed
                XCTAssert(i != nil)
            }
        }
    }*/
    
//    func testSimdMat() throws {
//        var A = Matrix(rows: 4, columns: 4)
//        A[0, 0] = 8; A[0, 1] = -5; A[0, 2] = 9; A[0, 3] = 2
//        A[1, 0] = 7; A[1, 1] = 5; A[1, 2] = 6; A[1, 3] = 1
//        A[2, 0] = -6; A[2, 1] = 0; A[2, 2] = 9; A[2, 3] = 6
//        A[3, 0] = -3; A[3, 1] = 0; A[3, 2] = -9; A[3, 3] = -4
//        
//        var B = matrix_identity_double4x4
//        B[0, 0] = 8; B[0, 1] = -5; B[0, 2] = 9; B[0, 3] = 2
//        B[1, 0] = 7; B[1, 1] = 5; B[1, 2] = 6; B[1, 3] = 1
//        B[2, 0] = -6; B[2, 1] = 0; B[2, 2] = 9; B[2, 3] = 6
//        B[3, 0] = -3; B[3, 1] = 0; B[3, 2] = -9; B[3, 3] = -4
//        
//        A = roundMatrix(M: A.inversed, digits: 5)
//        let R = roundMatrixSimd(M: B.inverse, digits: 5)
//        XCTAssert( A == R )
//    }
//
//    func roundMatrix(M: Matrix, digits: Double) -> Matrix {
//        var out = Matrix(size: M.columns)
//        
//        // round to 10^digits
//        for r in 0..<4 {
//            for c in 0..<4 {
//                out[r, c] = Double( round( pow(10, digits) * M[r, c] ) / pow(10, digits) )
//            }
//        }
//        
//        return out
//    }
//    
//    func roundMatrixSimd(M: simd_double4x4, digits: Double) -> Matrix {
//        var out = Matrix(size: 4)
//        
//        // round to 10^digits
//        for r in 0..<4 {
//            for c in 0..<4 {
//                out[r, c] = Double( round( pow(10, digits) * M[r, c] ) / pow(10, digits) )
//            }
//        }
//        
//        return out
//    }
}
