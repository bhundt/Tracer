//
//  MatrixTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 20.09.21.
//

import XCTest

class MatrixTest: XCTestCase {

    // p. 26
    func testMatrixComponents() throws {
        var M = Matrix(rows: 4, columns: 4)
        M[0, 0] = 1; M[0, 1] = 2; M[0, 2] = 3; M[0, 3] = 4
        M[1, 0] = 5.5; M[1, 1] = 6.5; M[1, 2] = 7.5; M[1, 3] = 8.5
        M[2, 0] = 9; M[2, 1] = 10; M[2, 2] = 11; M[2, 3] = 12
        M[3, 0] = 13.5; M[3, 1] = 14.5; M[3, 2] = 15.5; M[3, 3] = 16.5
        
        XCTAssertEqual(M[0,0], 1)
        XCTAssertEqual(M[0,3], 4)
        XCTAssertEqual(M[1,0], 5.5)
        XCTAssertEqual(M[1,2], 7.5)
        XCTAssertEqual(M[2,2], 11)
        XCTAssertEqual(M[3,0], 13.5)
        XCTAssertEqual(M[3,2], 15.5)
    }
    
    // p. 27
    func testMatrix2x2() throws {
        var M = Matrix(rows: 2, columns: 2)
        M[0, 0] = -3; M[0, 1] = 5
        M[1, 0] = 1; M[1, 1] = -2
        
        XCTAssertEqual(M[0,0], -3)
        XCTAssertEqual(M[0,1], 5)
        XCTAssertEqual(M[1,0], 1)
        XCTAssertEqual(M[1,1], -2)
    }
    
    // p. 27
    func testMatrix3x3() throws {
        var M = Matrix(rows: 3, columns: 3)
        M[0, 0] = -3; M[0, 1] = 5; M[0, 2] = 0
        M[1, 0] = 1; M[1, 1] = -2; M[0, 2] = -7
        M[2, 0] = 0; M[2, 1] = 1; M[2, 2] = 1
        
        XCTAssertEqual(M[0,0], -3)
        XCTAssertEqual(M[1,1], -2)
        XCTAssertEqual(M[2,2], 1)
    }
    
    // p. 27
    func testMatrixEqual() throws {
        var M1 = Matrix(rows: 4, columns: 4)
        M1[0, 0] = 1; M1[0, 1] = 2; M1[0, 2] = 3; M1[0, 3] = 4
        M1[1, 0] = 5; M1[1, 1] = 6; M1[1, 2] = 7; M1[1, 3] = 8
        M1[2, 0] = 9; M1[2, 1] = 10; M1[2, 2] = 11; M1[2, 3] = 12
        M1[3, 0] = 13; M1[3, 1] = 14; M1[3, 2] = 15; M1[3, 3] = 16
        
        var M2 = Matrix(rows: 4, columns: 4)
        M2[0, 0] = 1; M2[0, 1] = 2; M2[0, 2] = 3; M2[0, 3] = 4
        M2[1, 0] = 5; M2[1, 1] = 6; M2[1, 2] = 7; M2[1, 3] = 8
        M2[2, 0] = 9; M2[2, 1] = 10; M2[2, 2] = 11; M2[2, 3] = 12
        M2[3, 0] = 13; M2[3, 1] = 14; M2[3, 2] = 15; M2[3, 3] = 16
        
        XCTAssertTrue(M1 == M2)
    }
    
    // p. 27
    func testMatrixNotEqual() throws {
        var M1 = Matrix(rows: 4, columns: 4)
        M1[0, 0] = 0; M1[0, 1] = 2; M1[0, 2] = 3; M1[0, 3] = 4
        M1[1, 0] = 5; M1[1, 1] = 6; M1[1, 2] = 7; M1[1, 3] = 8
        M1[2, 0] = 9; M1[2, 1] = 10; M1[2, 2] = 11; M1[2, 3] = 12
        M1[3, 0] = 13; M1[3, 1] = 14; M1[3, 2] = 15; M1[3, 3] = 16
        
        var M2 = Matrix(rows: 4, columns: 4)
        M2[0, 0] = 1; M2[0, 1] = 2; M2[0, 2] = 3; M2[0, 3] = 4
        M2[1, 0] = 5; M2[1, 1] = 6; M2[1, 2] = 7; M2[1, 3] = 8
        M2[2, 0] = 9; M2[2, 1] = 10; M2[2, 2] = 11; M2[2, 3] = 12
        M2[3, 0] = 13; M2[3, 1] = 14; M2[3, 2] = 15; M2[3, 3] = 16
        
        XCTAssertTrue(M1 != M2)
    }
    
    // p. 28
    func testMultMatrices() throws {
        var M1 = Matrix(rows: 4, columns: 4)
        M1[0, 0] = 1; M1[0, 1] = 2; M1[0, 2] = 3; M1[0, 3] = 4
        M1[1, 0] = 5; M1[1, 1] = 6; M1[1, 2] = 7; M1[1, 3] = 8
        M1[2, 0] = 9; M1[2, 1] = 8; M1[2, 2] = 7; M1[2, 3] = 6
        M1[3, 0] = 5; M1[3, 1] = 4; M1[3, 2] = 3; M1[3, 3] = 2
        
        var M2 = Matrix(rows: 4, columns: 4)
        M2[0, 0] = -2; M2[0, 1] = 1; M2[0, 2] = 2; M2[0, 3] = 3
        M2[1, 0] = 3; M2[1, 1] = 2; M2[1, 2] = 1; M2[1, 3] = -1
        M2[2, 0] = 4; M2[2, 1] = 3; M2[2, 2] = 6; M2[2, 3] = 5
        M2[3, 0] = 1; M2[3, 1] = 2; M2[3, 2] = 7; M2[3, 3] = 8
        
        var  result = Matrix(rows: 4, columns: 4)
        result[0, 0] = 20; result[0, 1] = 22; result[0, 2] = 50; result[0, 3] = 48
        result[1, 0] = 44; result[1, 1] = 54; result[1, 2] = 114; result[1, 3] = 108
        result[2, 0] = 40; result[2, 1] = 58; result[2, 2] = 110; result[2, 3] = 102
        result[3, 0] = 16; result[3, 1] = 26; result[3, 2] = 46; result[3, 3] = 42
        
        XCTAssertTrue(M1 * M2 == result)
    }

    // -
    func testMultMatrices2x1() throws {
        var M = Matrix(rows: 2, columns: 2)
        M[0, 0] = -3; M[0, 1] = 5
        M[1, 0] = 1; M[1, 1] = -2
        
        var N = Matrix(rows: 2, columns: 1)
        N[0, 0] = -3
        N[1, 0] = 1
        
        var R = Matrix(rows: 2, columns: 1)
        R[0, 0] = 14
        R[1, 0] = -5
        
        XCTAssertEqual(R.rows, 2)
        XCTAssertEqual(R.columns, 1)
        XCTAssertTrue(M * N == R)
    }
    
    // p. 32
    func testMultiplyWithIdentity() throws {
        var M1 = Matrix(rows: 4, columns: 4)
        M1[0, 0] = 0; M1[0, 1] = 1; M1[0, 2] = 2; M1[0, 3] = 4
        M1[1, 0] = 1; M1[1, 1] = 2; M1[1, 2] = 4; M1[1, 3] = 8
        M1[2, 0] = 2; M1[2, 1] = 4; M1[2, 2] = 8; M1[2, 3] = 16
        M1[3, 0] = 4; M1[3, 1] = 8; M1[3, 2] = 16; M1[3, 3] = 32
        
        let M2 = Matrix.makeIdentity(size: 4)
        
        XCTAssert(M1*M2 == M1)
    }
    
    // p. 32
    func testMultiplyIdentityWithTuple() throws {
        let M = Matrix.makeIdentity(size: 4)
        let a = Tuple(x: 1, y: 2, z: 3, w: 4)
        
        XCTAssert(M*a == a)
    }
    
    // p. 33
    func testTransposeMatrix() throws {
        var M = Matrix(rows: 4, columns: 4)
        M[0, 0] = 0; M[0, 1] = 9; M[0, 2] = 3; M[0, 3] = 0
        M[1, 0] = 9; M[1, 1] = 8; M[1, 2] = 0; M[1, 3] = 8
        M[2, 0] = 1; M[2, 1] = 8; M[2, 2] = 5; M[2, 3] = 3
        M[3, 0] = 0; M[3, 1] = 0; M[3, 2] = 5; M[3, 3] = 8
        
        var R = Matrix(rows: 4, columns: 4)
        R[0, 0] = 0; R[0, 1] = 9; R[0, 2] = 1; R[0, 3] = 0
        R[1, 0] = 9; R[1, 1] = 8; R[1, 2] = 8; R[1, 3] = 0
        R[2, 0] = 3; R[2, 1] = 0; R[2, 2] = 5; R[2, 3] = 5
        R[3, 0] = 0; R[3, 1] = 8; R[3, 2] = 3; R[3, 3] = 8
        
        XCTAssert(M.transposed == R)
    }
    
    func testTransposedIdentity() throws {
        let M = Matrix.makeIdentity(size: 4)
        XCTAssert(M.transposed == M)
    }
}
