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
}
