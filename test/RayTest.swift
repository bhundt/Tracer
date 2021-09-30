//
//  RayTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 22.09.21.
//

import XCTest

class RayTest: XCTestCase {
    // p. 58
    func testRayExists() throws {
        let o = Tuple.makePoint(x: 1, y: 2, z: 3)
        let d = Tuple.makeVector(x: 4, y: 5, z: 6)
        let r = Ray(origin: o, direction: d)
        XCTAssertEqual(r.direction, d)
        XCTAssertEqual(r.origin, o)
    }
    
    // p. 58
    func testComputePointFromDist() throws {
        let r = Ray(origin: Tuple.makePoint(x: 2, y: 3, z: 4), direction: Tuple.makeVector(x: 1, y: 0, z: 0))
        
        XCTAssertEqual( r.position(t: 0), Tuple.makePoint(x: 2, y: 3, z: 4))
        XCTAssertEqual( r.position(t: 1), Tuple.makePoint(x: 3, y: 3, z: 4))
        XCTAssertEqual( r.position(t: -1), Tuple.makePoint(x: 1, y: 3, z: 4))
        XCTAssertEqual( r.position(t: 2.5), Tuple.makePoint(x: 4.5, y: 3, z: 4))
    }
    
    // p. 59
    func testSphereRayIntersectionTwoPoints() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs.0?.t, 4.0)
        XCTAssertEqual(xs.1?.t, 6.0)
    }
    
    // p. 60
    func testSphereRayIntersectionOnePoint() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 1, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 2)
        XCTAssertNotNil(xs.0)
        XCTAssertNotNil(xs.1)
        XCTAssertEqual(xs.0?.t, 5.0)
        XCTAssertEqual(xs.1?.t, 5.0)
    }
    
    // p. 60
    func testSphereRayNoIntersection() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 2, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 0)
        XCTAssertNil(xs.0)
        XCTAssertNil(xs.1)
    }
    
    // p. 61
    func testRayStartsInsideSphere() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 0),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 2)
        XCTAssertNotNil(xs.0)
        XCTAssertNotNil(xs.1)
        XCTAssertEqual(xs.0?.t, -1.0)
        XCTAssertEqual(xs.1?.t, 1.0)
    }
    
    // p. 62
    func testRayStartsBehindSphere() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 2)
        XCTAssertNotNil(xs.0)
        XCTAssertNotNil(xs.1)
        XCTAssertEqual(xs.0?.t, -6.0)
        XCTAssertEqual(xs.1?.t, -4.0)
    }
    
    // p. 64
    func testIntersectSetsObjectOnIntersection() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = Sphere()
        
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 2)
        XCTAssertNotNil(xs.0)
        XCTAssertNotNil(xs.1)
        XCTAssertEqual(xs.0?.object as! Sphere, s)
        XCTAssertEqual(xs.0?.object as! Sphere, s)
    }
    
    // p. 69
    func testTranslateRay() throws {
        let r = Ray(origin: Tuple.makePoint(x: 1, y: 2, z: 3),
                    direction: Tuple.makeVector(x: 0, y: 1, z: 0))
        let trafo = Matrix4.makeTranslation(x: 3, y: 4, z: 5)
        
        let r2 =  r.transform(trafo: trafo)
        
        XCTAssertEqual(r2.origin, Tuple.makePoint(x: 4, y: 6, z: 8))
        XCTAssertEqual(r2.direction, Tuple.makeVector(x: 0, y: 1, z: 0))
    }
    
    // p. 69
    func testScaleRay() throws {
        let r = Ray(origin: Tuple.makePoint(x: 1, y: 2, z: 3),
                    direction: Tuple.makeVector(x: 0, y: 1, z: 0))
        let trafo = Matrix4.makeScaling(x: 2, y: 3, z: 4)
        
        let r2 =  r.transform(trafo: trafo)
        
        XCTAssertEqual(r2.origin, Tuple.makePoint(x: 2, y: 6, z: 12))
        XCTAssertEqual(r2.direction, Tuple.makeVector(x: 0, y: 3, z: 0))
    }
    
    // p. 69
    func testIntersectScaledRay() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        
        let s = Sphere(trafo: Matrix4.makeScaling(x: 2, y: 2, z: 2))
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        XCTAssertNotNil(xs.0)
        XCTAssertNotNil(xs.1)
        XCTAssertEqual(xs.0?.t, 3)
        XCTAssertEqual(xs.1?.t, 7)
    }
    
    // p. 69
    func testIntersectTranslateddRay() throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5),
                    direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        
        let s = Sphere(trafo: Matrix4.makeTranslation(x: 5, y: 0, z: 0))
        //let xs = r.intersect(sphere: s)
        let xs = Collider.intersect(ray: r, withSphere: s)
        
        //XCTAssertEqual(xs.count, 0)
        XCTAssertNil(xs.0)
        XCTAssertNil(xs.1)
    }
}
