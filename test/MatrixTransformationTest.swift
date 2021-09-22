//
//  MatrixTransformationTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 21.09.21.
//

import XCTest

class MatrixTransformationTest: XCTestCase {
    // p. 45
    func testMultiPointWithTranslation() throws {
        let trans = Matrix.makeTranslation(x: 5, y: -3, z: 2)
        let p = Tuple.makePoint(x: -3, y: 4, z: 5)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: 2, y: 1, z: 7))
    }
    
    // p. 45
    func testMultiPointWithInverseTranslation() throws {
        let trans = Matrix.makeTranslation(x: 5, y: -3, z: 2)
        let inv = trans.inversed
        let p = Tuple.makePoint(x: -3, y: 4, z: 5)
        XCTAssertEqual(inv * p, Tuple.makePoint(x: -8, y: 7, z: 3))
    }
    
    // p. 45
    func testMultiVectorWithTranslation() throws {
        let trans = Matrix.makeTranslation(x: 5, y: -3, z: 2)
        let v = Tuple.makeVector(x: -3, y: 4, z: 5)
        XCTAssertEqual(trans * v, v)
    }
    
    // p. 46
    func testScalePoint() throws {
        let trans = Matrix.makeScaling(x: 2, y: 3, z: 4)
        let p = Tuple.makePoint(x: -4, y: 6, z: 8)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: -8, y: 18, z: 32))
    }
    
    // p. 46
    func testScaleVector() throws {
        let trans = Matrix.makeScaling(x: 2, y: 3, z: 4)
        let v = Tuple.makeVector(x: -4, y: 6, z: 8)
        XCTAssertEqual(trans * v, Tuple.makeVector(x: -8, y: 18, z: 32))
    }
    
    // p. 46
    func testScaleInverseVector() throws {
        let trans = Matrix.makeScaling(x: 2, y: 3, z: 4)
        let inv = trans.inversed
        let v = Tuple.makeVector(x: -4, y: 6, z: 8)
        XCTAssertEqual(inv * v, Tuple.makeVector(x: -2, y: 2, z: 2))
    }
    
    // p. 46
    func testReflectionIsScaling() throws {
        let trans = Matrix.makeScaling(x: -1, y: 1, z: 1)
        let p = Tuple.makePoint(x: 2, y: 3, z: 4)
        XCTAssertEqual(trans * p, Tuple.makePoint(x: -2, y: 3, z: 4))
    }
    
    // p. 48
    func testRotateAroundXAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 1, z: 0)
        let halfQuarter = Matrix.makeRotationX(radians: Double.pi / 4)
        let fullQuarter = Matrix.makeRotationX(radians: Double.pi / 2)
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: 0, y: 2.squareRoot()/2, z: 2.squareRoot()/2) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: 0, y: 0, z: 1))
    }
    
    // p. 49
    func testRotateAroundYAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 0, z: 1)
        let halfQuarter = Matrix.makeRotationY(radians: Double.pi / 4)
        let fullQuarter = Matrix.makeRotationY(radians: Double.pi / 2)
        
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: 2.squareRoot()/2, y: 0, z: 2.squareRoot()/2) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: 1, y: 0, z: 0))
    }
    
    // p. 50
    func testRotateAroundZAxis() throws {
        let p = Tuple.makePoint(x: 0, y: 1, z: 0)
        let halfQuarter = Matrix.makeRotationZ(radians: Double.pi / 4)
        let fullQuarter = Matrix.makeRotationZ(radians: Double.pi / 2)
        
        XCTAssert( (halfQuarter * p) == Tuple.makePoint(x: -1*2.squareRoot()/2, y: 2.squareRoot()/2, z: 0) )
        XCTAssert( (fullQuarter * p) == Tuple.makePoint(x: -1, y: 0, z: 0))
    }
    
    // p. 52-53
    func testShearing() throws {
        let p = Tuple.makePoint(x: 2, y: 3, z: 4)
        
        var trafo = Matrix.makeShear(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 5, y: 3, z: 4))
        
        trafo = Matrix.makeShear(xy: 0, xz: 1, yx: 0, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 6, y: 3, z: 4))
        
        trafo = Matrix.makeShear(xy: 0, xz: 0, yx: 1, yz: 0, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 5, z: 4))
        
        trafo = Matrix.makeShear(xy: 0, xz: 0, yx: 0, yz: 1, zx: 0, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 7, z: 4))
        
        trafo = Matrix.makeShear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 1, zy: 0)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 3, z: 6))
        
        trafo = Matrix.makeShear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 0, zy: 1)
        XCTAssert( (trafo * p) == Tuple.makePoint(x: 2, y: 3, z: 7))
    }
    
    // p. 54
    func testIndividualTransformations() throws {
        let p = Tuple.makePoint(x: 1, y: 0, z: 1)
        let A = Matrix.makeRotationX(radians: Double.pi / 2)
        let B = Matrix.makeScaling(x: 5, y: 5, z: 5)
        let C = Matrix.makeTranslation(x: 10, y: 5, z: 7)
        
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
        let A = Matrix.makeRotationX(radians: Double.pi / 2)
        let B = Matrix.makeScaling(x: 5, y: 5, z: 5)
        let C = Matrix.makeTranslation(x: 10, y: 5, z: 7)
        
        let T = C * B * A
        XCTAssertEqual(T * p, Tuple.makePoint(x: 15, y: 0, z: 7))
    }
    
    // p. 55
    func testFluentApi() throws {
        let T = Matrix.makeIdentity(size: 4)
                .rotateX(radians: Double.pi / 2)
                .scale(x: 5, y: 5, z: 5)
                .translate(x: 10, y: 5, z: 7)
        
        let p = Tuple.makePoint(x: 1, y: 0, z: 1)
        XCTAssertEqual(T * p, Tuple.makePoint(x: 15, y: 0, z: 7))
    }
}
