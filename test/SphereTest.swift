//
//  SphereTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 22.09.21.
//

import XCTest

class SphereTest: XCTestCase {
    func testSpheresAreUnique() throws {
        let s1 = Sphere()
        let s2 = Sphere()
        
        XCTAssertNotEqual(s1, s2)
    }
    
    // p. 78
    func testNormalOnSphereAtX() throws {
        let s = Sphere()
        let n = s.localNormal(atPoint: Tuple.makePoint(x: 1, y: 0, z: 0))
        XCTAssertEqual(n, Tuple.makeVector(x: 1, y: 0, z: 0))
    }
    
    // p. 78
    func testNormalOnSphereAtY() throws {
        let s = Sphere()
        let n = s.localNormal(atPoint: Tuple.makePoint(x: 0, y: 1, z: 0))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 1, z: 0))
    }
    
    // p. 78
    func testNormalOnSphereAtZ() throws {
        let s = Sphere()
        let n = s.localNormal(atPoint: Tuple.makePoint(x: 0, y: 0, z: 1))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0, z: 1))
    }
    
    // p. 78
    func testNormalOnSphereAtOtherPoint() throws {
        let s = Sphere()
        let n = s.localNormal(atPoint: Tuple.makePoint(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
        XCTAssertEqual(n, Tuple.makeVector(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
    }
    
    // p. 78
    func testNormalIsNormalized() throws {
        let s = Sphere()
        let n = s.localNormal(atPoint: Tuple.makePoint(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
        XCTAssertEqual(n, Tuple.makeVector(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3).normalized)
    }
    
    // p. 80
    func testComputeNormalOnTranslatedSphere() throws {
        let s = Sphere()
        s.transform = Matrix4.makeTranslation(x: 0, y: 1, z: 0)
        
        let n = s.normalVec(atPoint: Tuple.makePoint(x: 0, y: 1.70711, z: -0.70711))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.70711, z: -0.70711))
    }
    
    // p. 80
    func testComputeNormalOnTransformedSphere() throws {
        let s = Sphere()
        s.transform = Matrix4.makeIdentity()
            .rotateZ(radians: Double.pi/5)
            .scale(x: 1, y: 0.5, z: 1)
        
        let n = s.normalVec(atPoint: Tuple.makePoint(x: 0, y: 2.0.squareRoot()/2, z: -2.0.squareRoot()/2))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.97014, z: -0.24254))
    }
    
    // p. 121
    func testSphereConformsToShapeProtocol() throws {
        let s = Sphere()
        let _ = s as Shape
    }
}
