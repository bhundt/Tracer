//
//  MaterialTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 23.09.21.
//

import XCTest

class MaterialTest: XCTestCase {
    // p. 84
    func testDefaultMaterial() throws {
        let m = Material()
        XCTAssertEqual(m.color, Color(red: 1, green: 1, blue: 1))
        XCTAssertEqual(m.ambient, 0.1)
        XCTAssertEqual(m.diffuse, 0.9)
        XCTAssertEqual(m.specular, 0.9)
        XCTAssertEqual(m.shininess, 200.0)
    }
}

class MaterialLightningTest: XCTestCase {
    // p. 86
    var m: Material = Material()
    var position: Tuple = Tuple.makePoint(x: 0, y: 0, z: 0)
    
    // p. 86
    func testLightingEyeBetweenSurfaceAndLight() throws {
        let eyev = Tuple.makeVector(x: 0, y: 0, z: -1)
        let normalv = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 0, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        let result = m.lighting(light: light, position: position, eyeVec: eyev, normalVec: normalv)
        
        XCTAssertEqual(result, Color(red: 1.9, green: 1.9, blue: 1.9))
    }
    
    // p. 86
    func testLightingEyeOffset() throws {
        let eyev = Tuple.makeVector(x: 0, y: 2.0.squareRoot()/2, z: -1*2.0.squareRoot()/2)
        let normalv = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 0, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        let result = m.lighting(light: light, position: position, eyeVec: eyev, normalVec: normalv)
        
        XCTAssertEqual(result, Color(red: 1.0, green: 1.0, blue: 1.0))
    }
    
    // p. 87
    func testLightingLightOffset() throws {
        let eyev = Tuple.makeVector(x: 0, y: 0, z: -1)
        let normalv = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        let result = m.lighting(light: light, position: position, eyeVec: eyev, normalVec: normalv)
        
        XCTAssertEqual(result, Color(red: 0.7364, green: 0.7364, blue: 0.7364))
    }
    
    // p. 87
    func testEyeAndLightReflectedDirect() throws {
        let eyev = Tuple.makeVector(x: 0, y: -1*2.0.squareRoot()/2, z: -1*2.0.squareRoot()/2)
        let normalv = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        let result = m.lighting(light: light, position: position, eyeVec: eyev, normalVec: normalv)
        
        XCTAssertEqual(result, Color(red: 1.6364, green: 1.6364, blue: 1.6364))
    }
    
    // p. 88
    func testLightBehindSurface() throws {
        let eyev = Tuple.makeVector(x: 0, y: 0, z: -1)
        let normalv = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 0, z: 10), color: Color(red: 1, green: 1, blue: 1))
        
        let result = m.lighting(light: light, position: position, eyeVec: eyev, normalVec: normalv)
        
        XCTAssertEqual(result, Color(red: 0.1, green: 0.1, blue: 0.1))
    }
}
