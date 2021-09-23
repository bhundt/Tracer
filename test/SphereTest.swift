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
    
    // p. 69
    func testSphereHasDefaultTrafo() throws {
        let s = Sphere()
        XCTAssertEqual(s.transform, Matrix4.makeIdentity())
    }
    
    // p. 69
    func testSphereCanChangeTrafo() throws {
        let s = Sphere()
        let t = Matrix4.makeTranslation(x: 2, y: 3, z: 4)
        s.transform = t
        
        XCTAssertEqual(s.transform, t)
    }
    
    // p. 78
    func testNormalOnSphereAtX() throws {
        let s = Sphere()
        let n = s.normal(at: Tuple.makePoint(x: 1, y: 0, z: 0))
        XCTAssertEqual(n, Tuple.makeVector(x: 1, y: 0, z: 0))
    }
    
    // p. 78
    func testNormalOnSphereAtY() throws {
        let s = Sphere()
        let n = s.normal(at: Tuple.makePoint(x: 0, y: 1, z: 0))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 1, z: 0))
    }
    
    // p. 78
    func testNormalOnSphereAtZ() throws {
        let s = Sphere()
        let n = s.normal(at: Tuple.makePoint(x: 0, y: 0, z: 1))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0, z: 1))
    }
    
    // p. 78
    func testNormalOnSphereAtOtherPoint() throws {
        let s = Sphere()
        let n = s.normal(at: Tuple.makePoint(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
        XCTAssertEqual(n, Tuple.makeVector(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
    }
    
    // p. 78
    func testNormalIsNormalized() throws {
        let s = Sphere()
        let n = s.normal(at: Tuple.makePoint(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3))
        XCTAssertEqual(n, Tuple.makeVector(x: 3.0.squareRoot()/3, y: 3.0.squareRoot()/3, z: 3.0.squareRoot()/3).normalized)
    }
    
    // p. 80
    func testComputeNormalOnTranslatedSphere() throws {
        let s = Sphere()
        s.transform = Matrix4.makeTranslation(x: 0, y: 1, z: 0)
        
        let n = s.normal(at: Tuple.makePoint(x: 0, y: 1.70711, z: -0.70711))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.70711, z: -0.70711))
    }
    
    // p. 80
    func testComputeNormalOnTransformedSphere() throws {
        let s = Sphere()
        s.transform = Matrix4.makeIdentity()
            .rotateZ(radians: Double.pi/5)
            .scale(x: 1, y: 0.5, z: 1)
        
        let n = s.normal(at: Tuple.makePoint(x: 0, y: 2.0.squareRoot()/2, z: -2.0.squareRoot()/2))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.97014, z: -0.24254))
    }
    
    // p. 85
    func testSphereHasMaterial() throws {
        let s = Sphere()
        let m = s.material
        XCTAssert(m is Material)
    }
    
    // p. 85
    func testSphereCanBeAssignedAMaterial() throws {
        let s = Sphere()
        var m = Material()
        m.ambient = 1.0
        s.material = m
        XCTAssertEqual(s.material, m)
    }
}
