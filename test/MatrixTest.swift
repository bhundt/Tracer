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
    
    // p. 33
    func testTransposedIdentity() throws {
        let M = Matrix.makeIdentity(size: 4)
        XCTAssert(M.transposed == M)
    }
    
    // p. 34
    func testDeterminant2x2() throws {
        var M = Matrix(rows: 2, columns: 2)
        M[0, 0] = 1; M[0, 1] = 5
        M[1, 0] = -3; M[1, 1] = 2
        
        XCTAssertEqual(M.determinant, 17)
    }
    
    // p. 35
    func testSubMatrix3x3is2x2() throws {
        var M = Matrix(rows: 3, columns: 3)
        M[0, 0] = 1; M[0, 1] = 5; M[0, 2] = 0
        M[1, 0] = -3; M[1, 1] = 2; M[1, 2] = 7
        M[2, 0] = 0; M[2, 1] = 6; M[2, 2] = -3
        
        var R = Matrix(rows: 2, columns: 2)
        R[0, 0] = -3; R[0, 1] = 2
        R[1, 0] = 0; R[1, 1] = 6
        
        XCTAssertTrue(M.submatrix(row: 0, col: 2) == R)
    }
    
    // p. 35
    func testSubMatrix4x4is3x3() throws {
        var M = Matrix(rows: 4, columns: 4)
        M[0, 0] = -6; M[0, 1] = 1; M[0, 2] = 1; M[0, 3] = 6
        M[1, 0] = -8; M[1, 1] = 5; M[1, 2] = 8; M[1, 3] = 6
        M[2, 0] = -1; M[2, 1] = 0; M[2, 2] = 8; M[2, 3] = 2
        M[3, 0] = -7; M[3, 1] = 1; M[3, 2] = -1; M[3, 3] = 1
        
        var R = Matrix(rows: 3, columns: 3)
        R[0, 0] = -6; R[0, 1] = 1; R[0, 2] = 6
        R[1, 0] = -8; R[1, 1] = 8; R[1, 2] = 6
        R[2, 0] = -7; R[2, 1] = -1; R[2, 2] = 1
        
        XCTAssertTrue(M.submatrix(row: 2, col: 1) == R)
    }
    
    // p. 35
    func testMinor3x3() throws {
        var A = Matrix(rows: 3, columns: 3)
        A[0, 0] = 3; A[0, 1] = 5; A[0, 2] = 0
        A[1, 0] = 2; A[1, 1] = -1; A[1, 2] = 7
        A[2, 0] = 6; A[2, 1] = -1; A[2, 2] = 5
        
        let B = A.submatrix(row: 1,col: 0)
        
        XCTAssert( B.determinant == 25 )
        XCTAssert( A.minor(row: 1, col: 0) == 25 )
    }
    
    // p. 36
    func testCofactor() throws {
        var A = Matrix(rows: 3, columns: 3)
        A[0, 0] = 3; A[0, 1] = 5; A[0, 2] = 0
        A[1, 0] = 2; A[1, 1] = -1; A[1, 2] = -7
        A[2, 0] = 6; A[2, 1] = -1; A[2, 2] = 5
        
        XCTAssert( A.minor(row: 0, col: 0) == -12 )
        XCTAssert( A.cofactor(row: 0, col: 0) == -12 )
        XCTAssert( A.minor(row: 1, col: 0) == 25 )
        XCTAssert( A.cofactor(row: 1, col: 0) == -25 )
    }
    
    // p. 37
    func testDeterminant3x3() throws {
        var A = Matrix(rows: 3, columns: 3)
        A[0, 0] = 1; A[0, 1] = 2; A[0, 2] = 6
        A[1, 0] = -5; A[1, 1] = 8; A[1, 2] = -4
        A[2, 0] = 2; A[2, 1] = 6; A[2, 2] = 4
        
        XCTAssert( A.cofactor(row: 0, col: 0) == 56 )
        XCTAssert( A.cofactor(row: 0, col: 1) == 12 )
        XCTAssert( A.cofactor(row: 0, col: 2) == -46 )
        XCTAssert( A.determinant == -196 )
    }
    
    // p. 37
    func testDeterminant4x4() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = -2; A[0, 1] = -8; A[0, 2] = 3; A[0, 3] = 5
        A[1, 0] = -3; A[1, 1] = 1; A[1, 2] = 7; A[1, 3] = 3
        A[2, 0] = 1; A[2, 1] = 2; A[2, 2] = -9; A[2, 3] = 6
        A[3, 0] = -6; A[3, 1] = 7; A[3, 2] = 7; A[3, 3] = -9
        
        XCTAssert( A.cofactor(row: 0, col: 0) == 690 )
        XCTAssert( A.cofactor(row: 0, col: 1) == 447 )
        XCTAssert( A.cofactor(row: 0, col: 2) == 210 )
        XCTAssert( A.cofactor(row: 0, col: 3) == 51 )
        XCTAssert( A.determinant == -4071 )
    }
    
    // p. 39
    func testInvertibleMatrixDetected() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = 6; A[0, 1] = 4; A[0, 2] = 4; A[0, 3] = 4
        A[1, 0] = 5; A[1, 1] = 5; A[1, 2] = 7; A[1, 3] = 6
        A[2, 0] = 4; A[2, 1] = -9; A[2, 2] = 3; A[2, 3] = -7
        A[3, 0] = 9; A[3, 1] = 1; A[3, 2] = 7; A[3, 3] = -6
        
        XCTAssert( A.determinant == -2120 )
        XCTAssertTrue( A.invertible )
    }
    
    // p. 39
    func testNonInvertibleMatrixDetected() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = -4; A[0, 1] = 2; A[0, 2] = -2; A[0, 3] = -3
        A[1, 0] = 9; A[1, 1] = 6; A[1, 2] = 2; A[1, 3] = 6
        A[2, 0] = 0; A[2, 1] = -5; A[2, 2] = 1; A[2, 3] = -5
        A[3, 0] = 0; A[3, 1] = 0; A[3, 2] = 0; A[3, 3] = 0
        
        XCTAssert( A.determinant == 0 )
        XCTAssertFalse( A.invertible )
    }
    
    // p. 39
    func testCalculateInverse() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = -5; A[0, 1] = 2; A[0, 2] = 6; A[0, 3] = -8
        A[1, 0] = 1; A[1, 1] = -5; A[1, 2] = 1; A[1, 3] = 8
        A[2, 0] = 7; A[2, 1] = 7; A[2, 2] = -6; A[2, 3] = -7
        A[3, 0] = 1; A[3, 1] = -3; A[3, 2] = 7; A[3, 3] = 4
        
        var B = A.inversed
        
        XCTAssert( A.determinant == 532 )
        XCTAssert( A.cofactor(row: 2, col: 3) == -160 )
        XCTAssert( B[3, 2] == -160/532 )
        XCTAssert( A.cofactor(row: 3, col: 2) == 105 )
        XCTAssert( B[2, 3] == 105/532 )
        
        var R = Matrix(size: 4)
        R[0, 0] = 0.21805; R[0, 1] = 0.45113; R[0, 2] = 0.24060; R[0, 3] = -0.04511
        R[1, 0] = -0.80827; R[1, 1] = -1.45677; R[1, 2] = -0.44361; R[1, 3] = 0.52068
        R[2, 0] = -0.07895; R[2, 1] = -0.22368; R[2, 2] = -0.05263; R[2, 3] = 0.19737
        R[3, 0] = -0.52256; R[3, 1] = -0.81391; R[3, 2] = -0.30075; R[3, 3] = 0.30639
    
        B = roundMatrix(M: B, digits: 5)
        XCTAssert( B == R )
    }
    
    // p. 41
    func testCalculateMoreInverses1() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = 8; A[0, 1] = -5; A[0, 2] = 9; A[0, 3] = 2
        A[1, 0] = 7; A[1, 1] = 5; A[1, 2] = 6; A[1, 3] = 1
        A[2, 0] = -6; A[2, 1] = 0; A[2, 2] = 9; A[2, 3] = 6
        A[3, 0] = -3; A[3, 1] = 0; A[3, 2] = -9; A[3, 3] = -4
        
        var R = Matrix(size: 4)
        R[0, 0] = -0.15385; R[0, 1] = -0.15385; R[0, 2] = -0.28205; R[0, 3] = -0.53846
        R[1, 0] = -0.07692; R[1, 1] = 0.12308; R[1, 2] = 0.02564; R[1, 3] = 0.03077
        R[2, 0] = 0.35897; R[2, 1] = 0.35897; R[2, 2] = 0.43590; R[2, 3] = 0.92308
        R[3, 0] = -0.69231; R[3, 1] = -0.69231; R[3, 2] = -0.76923; R[3, 3] = -1.92308
        
        A = roundMatrix(M: A.inversed, digits: 5)
        XCTAssert( A == R )
    }
    
    // p. 41
    func testCalculateMoreInverses2() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = 9; A[0, 1] = 3; A[0, 2] = 0; A[0, 3] = 9
        A[1, 0] = -5; A[1, 1] = -2; A[1, 2] = -6; A[1, 3] = -3
        A[2, 0] = -4; A[2, 1] = 9; A[2, 2] = 6; A[2, 3] = 4
        A[3, 0] = -7; A[3, 1] = 6; A[3, 2] = 6; A[3, 3] = 2
        
        var R = Matrix(size: 4)
        R[0, 0] = -0.04074; R[0, 1] = -0.07778; R[0, 2] = 0.14444; R[0, 3] = -0.22222
        R[1, 0] = -0.07778; R[1, 1] = 0.03333; R[1, 2] = 0.36667; R[1, 3] = -0.33333
        R[2, 0] = -0.02901; R[2, 1] = -0.14630; R[2, 2] = -0.10926; R[2, 3] = 0.12963
        R[3, 0] = 0.17778; R[3, 1] = 0.06667; R[3, 2] = -0.26667; R[3, 3] = 0.33333
        
        A = roundMatrix(M: A.inversed, digits: 5)
        XCTAssert( A == R )
    }
    
    // p. 41
    func testMultiplyWithInverse() throws {
        var A = Matrix(rows: 4, columns: 4)
        A[0, 0] = 3; A[0, 1] = -9; A[0, 2] = 7; A[0, 3] = 3
        A[1, 0] = 3; A[1, 1] = -8; A[1, 2] = 2; A[1, 3] = -9
        A[2, 0] = -4; A[2, 1] = 4; A[2, 2] = 4; A[2, 3] = 1
        A[3, 0] = -6; A[3, 1] = 5; A[3, 2] = 1; A[3, 3] = 1
        
        var B = Matrix(rows: 4, columns: 4)
        B[0, 0] = 8; B[0, 1] = 2; B[0, 2] = 2; B[0, 3] = 2
        B[1, 0] = 3; B[1, 1] = -1; B[1, 2] = 7; B[1, 3] = 0
        B[2, 0] = 7; B[2, 1] = 0; B[2, 2] = 5; B[2, 3] = 4
        B[3, 0] = 6; B[3, 1] = -2; B[3, 2] = 0; B[3, 3] = 5
        
        let C = A * B
        let I = roundMatrix(M: C * B.inversed, digits: 0)
        XCTAssert( I == A )
    }
    
    func roundMatrix(M: Matrix, digits: Double) -> Matrix {
        var out = Matrix(size: M.columns)
        
        // round to 10^digits
        for r in 0..<M.rows {
            for c in 0..<M.columns {
                out[r, c] = Double( round( pow(10, digits) * M[r, c] ) / pow(10, digits) )
            }
        }
        
        return out
    }
}
