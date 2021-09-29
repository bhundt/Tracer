//
//  Matrix4TransformationTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 23.09.21.
//

import XCTest

class Matrix4TransformationTest: XCTestCase {
    // p. 45
    func testMultiPointWithTranslation() throws {
        let trans = Matrix4.makeTranslation(x: 5, y: -3, z: 2)
        let p = Tuple.makePoint(x: -3, y: 4, z: 5)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: 2, y: 1, z: 7))
    }
    
    // p. 45
    func testMultiPointWithInverseTranslation() throws {
        let trans = Matrix4.makeTranslation(x: 5, y: -3, z: 2)
        let inv = trans.inversed
        let p = Tuple.makePoint(x: -3, y: 4, z: 5)
        XCTAssertEqual(inv * p, Tuple.makePoint(x: -8, y: 7, z: 3))
    }
    
    // p. 45
    func testMultiVectorWithTranslation() throws {
        let trans = Matrix4.makeTranslation(x: 5, y: -3, z: 2)
        let v = Tuple.makeVector(x: -3, y: 4, z: 5)
        XCTAssertEqual(trans * v, v)
    }
    
    // p. 46
    func testScalePoint() throws {
        let trans = Matrix4.makeScaling(x: 2, y: 3, z: 4)
        let p = Tuple.makePoint(x: -4, y: 6, z: 8)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: -8, y: 18, z: 32))
    }
    
    // p. 46
    func testScaleVector() throws {
        let trans = Matrix4.makeScaling(x: 2, y: 3, z: 4)
        let v = Tuple.makeVector(x: -4, y: 6, z: 8)
        XCTAssertEqual(trans * v, Tuple.makeVector(x: -8, y: 18, z: 32))
    }
    
    // p. 46
    func testScaleInverseVector() throws {
        let trans = Matrix4.makeScaling(x: 2, y: 3, z: 4)
        let inv = trans.inversed
        let v = Tuple.makeVector(x: -4, y: 6, z: 8)
        XCTAssertEqual(inv * v, Tuple.makeVector(x: -2, y: 2, z: 2))
    }
    
    // p. 46
    func testReflectionIsScaling() throws {
        let trans = Matrix4.makeScaling(x: -1, y: 1, z: 1)
        let p = Tuple.makePoint(x: 2, y: 3, z: 4)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: -2, y: 3, z: 4))
    }
    
    // p. 48
    func testRotateAroundXAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 1, z: 0)
        let halfQuarter = Matrix4.makeRotationX(radians: Double.pi / 4)
        let fullQuarter = Matrix4.makeRotationX(radians: Double.pi / 2)
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: 0, y: 2.squareRoot()/2, z: 2.squareRoot()/2) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: 0, y: 0, z: 1))
    }
    
    // p. 49
    func testRotateAroundYAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 0, z: 1)
        let halfQuarter = Matrix4.makeRotationY(radians: Double.pi / 4)
        let fullQuarter = Matrix4.makeRotationY(radians: Double.pi / 2)
        
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: 2.squareRoot()/2, y: 0, z: 2.squareRoot()/2) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: 1, y: 0, z: 0))
    }
    
    // p. 50
    func testRotateAroundZAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 1, z: 0)
        let halfQuarter = Matrix4.makeRotationZ(radians: Double.pi / 4)
        let fullQuarter = Matrix4.makeRotationZ(radians: Double.pi / 2)
        
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: -1*2.squareRoot()/2, y: 2.squareRoot()/2, z: 0) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: -1, y: 0, z: 0))
    }
    
    // p. 52-53
    func testShearing() throws {
        let p = Tuple.makePoint(x: 2, y: 3, z: 4)
        
        var trafo = Matrix4.makeShear(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 5, y: 3, z: 4))
        
        trafo = Matrix4.makeShear(xy: 0, xz: 1, yx: 0, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 6, y: 3, z: 4))
        
        trafo = Matrix4.makeShear(xy: 0, xz: 0, yx: 1, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 5, z: 4))
        
        trafo = Matrix4.makeShear(xy: 0, xz: 0, yx: 0, yz: 1, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 7, z: 4))
        
        trafo = Matrix4.makeShear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 1, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 3, z: 6))
        
        trafo = Matrix4.makeShear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 0, zy: 1)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 3, z: 7))
    }
    
    // p. 54
    func testIndividualTransformations() throws {
        let p = Tuple.makePoint(x: 1, y: 0, z: 1)
        let A = Matrix4.makeRotationX(radians: Double.pi / 2)
        let B = Matrix4.makeScaling(x: 5, y: 5, z: 5)
        let C = Matrix4.makeTranslation(x: 10, y: 5, z: 7)
        
        let p2 = A * p
        XCTAssert( p2 == Tuple.makePoint(x: 1, y: -1, z: 0) )
        
        let p3 = B * p2
        XCTAssert( p3 == Tuple.makePoint(x: 5, y: -5, z: 0) )
        
        let p4 = C * p3
        XCTAssert( p4 == Tuple.makePoint(x: 15, y: 0, z: 7) )
    }
    
    // p. 54
    func testChainedTransformations() throws {
        let p = Tuple.makePoint(x: 1, y: 0, z: 1)
        let A = Matrix4.makeRotationX(radians: Double.pi / 2)
        let B = Matrix4.makeScaling(x: 5, y: 5, z: 5)
        let C = Matrix4.makeTranslation(x: 10, y: 5, z: 7)
        
        let T = C * B * A
        XCTAssertEqual(T * p, Tuple.makePoint(x: 15, y: 0, z: 7))
    }
    
    // p. 55
    func testFluentApi() throws {
        let T = Matrix4.makeIdentity()
                .rotateX(radians: Double.pi / 2)
                .scale(x: 5, y: 5, z: 5)
                .translate(x: 10, y: 5, z: 7)
        
        let p = Tuple.makePoint(x: 1, y: 0, z: 1)
        XCTAssertEqual(T * p, Tuple.makePoint(x: 15, y: 0, z: 7))
    }
    
    // p. 98
    func testDefaultViewTransform() throws {
        let from = Tuple.makePoint(x: 0, y: 0, z: 0)
        let to = Tuple.makePoint(x: 0, y: 0, z: -1)
        let up = Tuple.makeVector(x: 0, y: 1, z: 0)
        
        let t = Matrix4.makeviewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, Matrix4.makeIdentity())
    }
    
    // p. 98
    func testViewTransformPositiveZAxis() throws {
        let from = Tuple.makePoint(x: 0, y: 0, z: 0)
        let to = Tuple.makePoint(x: 0, y: 0, z: 1)
        let up = Tuple.makeVector(x: 0, y: 1, z: 0)
        
        let t = Matrix4.makeviewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, Matrix4.makeScaling(x: -1, y: 1, z: -1))
    }
    
    // p. 99
    func testViewTransformMovesTheWorld() throws {
        let from = Tuple.makePoint(x: 0, y: 0, z: 8)
        let to = Tuple.makePoint(x: 0, y: 0, z: 1)
        let up = Tuple.makeVector(x: 0, y: 1, z: 0)
        
        let t = Matrix4.makeviewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, Matrix4.makeTranslation(x: 0, y: 0, z: -8))
    }
    
    // p. 99
    func testSomeViewTransformation() throws {
        let from = Tuple.makePoint(x: 1, y: 3, z: 2)
        let to = Tuple.makePoint(x: 4, y: -2, z: 8)
        let up = Tuple.makeVector(x: 1, y: 1, z: 0)
        
        let t = Matrix4.makeviewTransform(from: from, to: to, up: up)
        
        var R = Matrix4()
        R[0, 0] = -0.50709; R[0, 1] = 0.50709; R[0, 2] = 0.67612; R[0, 3] = -2.36643
        R[1, 0] = 0.76772; R[1, 1] = 0.60609; R[1, 2] = 0.12122; R[1, 3] = -2.82843
        R[2, 0] = -0.35857; R[2, 1] = 0.59761; R[2, 2] = -0.71714; R[2, 3] = 0.00000
        R[3, 0] = 0.00000; R[3, 1] = 0.00000; R[3, 2] = 0.00000; R[3, 3] = 1.00000
        
        XCTAssertEqual(t, R)
    }
}
