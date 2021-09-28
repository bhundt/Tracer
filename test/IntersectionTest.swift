//
//  IntersectionTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 22.09.21.
//

import XCTest

class IntersectionTest: XCTestCase {
    // p. 63
    func testIntersectionExists() throws {
        let s = Sphere()
        let i = Intersection(t: 3.5, obj: s)
        XCTAssertEqual(i.t, 3.5)
        XCTAssertEqual(i.object as! Sphere, s)
    }
    
    // p. 64
    func testAggregatingIntersections() throws {
        let s = Sphere()
        let i1 = Intersection(t: 1, obj: s)
        let i2 = Intersection(t: 2, obj: s)
        
        let xs = [i1, i2]
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[1].t, 2)
    }
    
    // p. 65
    func testHitWithAllPositiveT() throws {
        let s = Sphere()
        let i1 = Intersection(t: 1, obj: s)
        let i2 = Intersection(t: 2, obj: s)
        let xs = [i1, i2]
        
        let i = xs.hit()!

        XCTAssertEqual(i, i1)
    }
    
    // p. 65
    func testHitWithOneNegativeT() throws {
        let s = Sphere()
        let i1 = Intersection(t: -1, obj: s)
        let i2 = Intersection(t: 1, obj: s)
        let xs = [i1, i2]
        
        let i = xs.hit()!

        XCTAssertEqual(i, i2)
    }
    
    // p. 65
    func testHitWithAllNegativeT() throws {
        let s = Sphere()
        let i1 = Intersection(t: -2, obj: s)
        let i2 = Intersection(t: -1, obj: s)
        let xs = [i1, i2]

        XCTAssertNil(xs.hit())
    }
    
    // p. 65
    func testHitIsAlwaysWithLowestT() throws {
        let s = Sphere()
        let i1 = Intersection(t: 5, obj: s)
        let i2 = Intersection(t: 7, obj: s)
        let i3 = Intersection(t: -3, obj: s)
        let i4 = Intersection(t: 2, obj: s)
        let xs = [i1, i2, i3, i4]
        
        let i = xs.hit()!

        XCTAssertEqual(i, i4)
    }
    
    // p. 93
    func testPrecomputingTheStateOfIntersection() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let shape = Sphere()
        let i = Intersection(t: 4.0, obj: shape)
        
        let comps = i.prepareComputation(ray: r)
        
        XCTAssertEqual(comps.t, i.t)
        XCTAssertEqual(comps.object as! Sphere, i.object as! Sphere)
        XCTAssertEqual(comps.point, Tuple.makePoint(x: 0, y: 0, z: -1))
        XCTAssertEqual(comps.eyeVec, Tuple.makeVector(x: 0, y: 0, z: -1))
        XCTAssertEqual(comps.normalVec, Tuple.makeVector(x: 0, y: 0, z: -1))
    }
    
    // p. 94
    func testHitOutsideOfSphere() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let shape = Sphere()
        let i = Intersection(t: 4.0, obj: shape)
        
        let comps = i.prepareComputation(ray: r)
        XCTAssertFalse(comps.inside)
    }
    
    // p. 94
    func testHitInsideOfSphere() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 0), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let shape = Sphere()
        let i = Intersection(t: 1.0, obj: shape)
        
        let comps = i.prepareComputation(ray: r)
        
        XCTAssertEqual(comps.point, Tuple.makePoint(x: 0, y: 0, z: 1))
        XCTAssertEqual(comps.eyeVec, Tuple.makeVector(x: 0, y: 0, z: -1))
        XCTAssertEqual(comps.normalVec, Tuple.makeVector(x: 0, y: 0, z: -1))
        XCTAssertTrue(comps.inside)
    }
}
