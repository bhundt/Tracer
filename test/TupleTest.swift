//
//  TracerTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 19.09.21.
//

import XCTest

class TupleTest: XCTestCase {
    func testTupleTypeExists() throws {
        _ = Tuple(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
        XCTAssert(true)
    }
    
    // p. 4
    func testTupleIsPoint() throws {
        let t = Tuple.makePoint(x: 4.3, y: -4.2, z: 3.1)
        XCTAssertEqual(t.x, 4.3)
        XCTAssertEqual(t.y, -4.2)
        XCTAssertEqual(t.z, 3.1)
        XCTAssertEqual(t.w, 1.0)
        XCTAssertTrue(t.isPoint)
        XCTAssertFalse(t.isVector)
    }
    
    // p. 4
    func testTupleIsVector() throws {
        let t = Tuple.makeVector(x: 4.3, y: -4.2, z: 3.1)
        XCTAssertEqual(t.x, 4.3)
        XCTAssertEqual(t.y, -4.2)
        XCTAssertEqual(t.z, 3.1)
        XCTAssertEqual(t.w, 0.0)
        XCTAssertFalse(t.isPoint)
        XCTAssertTrue(t.isVector)
    }
    
    // p. 6
    func testAddTwoTuples() throws {
        let a1 = Tuple(x: 3, y: -2, z: 5, w: 1)
        let a2 = Tuple(x: -2, y: 3, z: 1, w: 0)
        
        XCTAssertEqual(a1 + a2, Tuple(x: 1, y: 1, z: 6, w: 1))
    }
    
    // p. 6
    func testSubTwoPoints() throws {
        let p1 = Tuple.makePoint(x: 3, y: 2, z: 1)
        let p2 = Tuple.makePoint(x: 5, y: 6, z: 7)
        
        XCTAssertEqual(p1 - p2, Tuple(x: -2, y: -4, z: -6, w: 0))
        XCTAssertTrue((p1 - p2).isVector)
    }
    
    // p. 6
    func testSubVecFromPoint() throws {
        let p = Tuple.makePoint(x: 3, y: 2, z: 1)
        let v = Tuple.makeVector(x: 5, y: 6, z: 7)
        
        XCTAssertEqual(p - v, Tuple(x: -2, y: -4, z: -6, w: 1))
        XCTAssertTrue((p - v).isPoint)
    }
    
    // p. 7
    func testSubTwoVecs() throws {
        let v1 = Tuple.makeVector(x: 3, y: 2, z: 1)
        let v2 = Tuple.makeVector(x: 5, y: 6, z: 7)
        
        XCTAssertEqual(v1 - v2, Tuple(x: -2, y: -4, z: -6, w: 0))
        XCTAssertTrue((v1 - v2).isVector)
    }
    
    // p. 7
    func testNegateVecBySubtraction() throws {
        let zero = Tuple.makeVector(x: 0, y: 0, z: 0)
        let v = Tuple.makeVector(x: 1, y: -2, z: 3)
        
        XCTAssertEqual(zero - v, Tuple(x: -1, y: 2, z: -3, w: 0))
    }
    
    // p. 7
    func testNegateVecByOperator() throws {
        let a = Tuple(x: 1, y: -2, z: 3, w: -4)
        XCTAssertEqual(-a, Tuple(x: -1, y: 2, z: -3, w: 4))
    }
    
    //p. 8
    func testMultiplyVecByScalar() throws {
        let a = Tuple(x: 1, y: -2, z: 3, w: -4)
        XCTAssertEqual(a * 3.5, Tuple(x: 3.5, y: -7, z: 10.5, w: -14))
        XCTAssertEqual(3.5 * a, Tuple(x: 3.5, y: -7, z: 10.5, w: -14))
    }
    
    //p. 8
    func testMultiplyVecByScalarFraction() throws {
        let a = Tuple(x: 1, y: -2, z: 3, w: -4)
        XCTAssertEqual(a * 0.5, Tuple(x: 0.5, y: -1, z: 1.5, w: -2))
        XCTAssertEqual(0.5 * a, Tuple(x: 0.5, y: -1, z: 1.5, w: -2))
    }
    
    // p. 8
    func testDivisionByScalar() throws {
        let a = Tuple(x: 1, y: -2, z: 3, w: -4)
        XCTAssertEqual(a / 2, Tuple(x: 0.5, y: -1, z: 1.5, w: -2))
    }
    
    // p. 8
    func testLengthOfTuple() throws {
        var v = Tuple.makeVector(x: 1, y: 0, z: 0)
        XCTAssertEqual(v.length, 1)
        
        v = Tuple.makeVector(x: 0, y: 1, z: 0)
        XCTAssertEqual(v.length, 1)
        
        v = Tuple.makeVector(x: 0, y: 0, z: 1)
        XCTAssertEqual(v.length, 1)
        
        v = Tuple.makeVector(x: 1, y: 2, z: 3)
        XCTAssertEqual(v.length, 14.squareRoot())
        
        v = Tuple.makeVector(x: -1, y: -2, z: -3)
        XCTAssertEqual(v.length, 14.squareRoot())
    }
    
    // p. 10
    func testNormalizeVec() throws {
        var v = Tuple.makeVector(x: 4, y: 0, z: 0)
        XCTAssertEqual(v.getNormalized(), Tuple(x: 1, y: 0, z: 0, w: 0))
        
        v = Tuple.makeVector(x: 1, y: 2, z: 3)
        XCTAssertEqual(v.getNormalized(), Tuple(x: 1/14.squareRoot(),
                                                y: 2/14.squareRoot(),
                                                z: 3/14.squareRoot(),
                                                w: 0))
        
        v = Tuple.makeVector(x: 1, y: 2, z: 3)
        XCTAssertEqual(v.getNormalized().length, 1.0)
    }
    
    // p. 10
    func testDotProduct() throws {
        let a = Tuple.makeVector(x: 1, y: 2, z: 3)
        let b = Tuple.makeVector(x: 2, y: 3, z: 4)
        
        XCTAssertEqual(a.dot(withVector: b), 20.0)
    }
    
    // p. 10
    func testCrossProduct() throws {
        let a = Tuple.makeVector(x: 1, y: 2, z: 3)
        let b = Tuple.makeVector(x: 2, y: 3, z: 4)
        
        XCTAssertEqual(a.cross(withVector: b), Tuple.makeVector(x: -1, y: 2, z: -1))
        XCTAssertEqual(b.cross(withVector: a), Tuple.makeVector(x: 1, y: -2, z: 1))
    }
    
    // p. 83
    func testReflectVector45Degrees() throws {
        let v = Tuple.makeVector(x: 1, y: -1, z: 0)
        let n = Tuple.makeVector(x: 0, y: 1, z: 0)
        let r = v.reflect(normal: n)
        XCTAssertEqual(r, Tuple.makeVector(x: 1, y: 1, z: 0))
    }
    
    // p. 83
    func testReflectVectorSlanted() throws {
        let v = Tuple.makeVector(x: 0, y: -1, z: 0)
        let n = Tuple.makeVector(x: 2.0.squareRoot()/2, y: 2.0.squareRoot()/2, z: 0)
        let r = v.reflect(normal: n)
        XCTAssertEqual(r, Tuple.makeVector(x: 1, y: 0, z: 0))
    }
}
