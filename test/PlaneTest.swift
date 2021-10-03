//
//  PlaneTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 03.10.21.
//

import XCTest

class PlaneTest: XCTestCase {
    // p. 122
    func testNormalPlaneAlwaysConstant() throws {
        let p = Plane()
        let n1 = p.localNormal(atPoint: Tuple.makePoint(x: 0, y: 0, z: 0))
        let n2 = p.localNormal(atPoint: Tuple.makePoint(x: 10, y: 0, z: -10))
        let n3 = p.localNormal(atPoint: Tuple.makePoint(x: -5, y: 0, z: 150))
        
        XCTAssertEqual(n1, Tuple.makeVector(x: 0, y: 1, z: 0))
        XCTAssertEqual(n2, Tuple.makeVector(x: 0, y: 1, z: 0))
        XCTAssertEqual(n3, Tuple.makeVector(x: 0, y: 1, z: 0))
    }
    
    // p. 122
    func testIntersectRayParallelToPlane() throws {
        let p = Plane()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 10, z: 0), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let xs = p.localIntersect(withRay: r)
        XCTAssertEqual(xs.count, 0)
    }
    
    // p. 123
    func testIntersectRayCoplanarToPlane() throws {
        let p = Plane()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 0), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let xs = p.localIntersect(withRay: r)
        XCTAssertEqual(xs.count, 0)
    }
    
    // p. 123
    func testRayIntersectingPlaneFromAbove() throws {
        let p = Plane()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 1, z: 0), direction: Tuple.makeVector(x: 0, y: -1, z: 0))
        let xs = p.localIntersect(withRay: r)
        
        XCTAssertEqual(xs.count, 1)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[0].object as! Plane, p)
    }
    
    // p. 123
    func testRayIntersectingPlaneFromBelow() throws {
        let p = Plane()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: -1, z: 0), direction: Tuple.makeVector(x: 0, y: 1, z: 0))
        let xs = p.localIntersect(withRay: r)
        
        XCTAssertEqual(xs.count, 1)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[0].object as! Plane, p)
    }

}
