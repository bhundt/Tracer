//
//  PatternTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 05.10.21.
//

import XCTest

class PatternTest: XCTestCase {
    
    var black = Color(red: 0, green: 0, blue: 0)
    var white = Color(red: 1, green: 1, blue: 1)
    
    // p. 128
    func testCreateStripePattern() throws {
        let _ = StripePattern(color1: white, color2: black)
    }
    
    // p. 129
    func testStripePatternConstInY() throws {
        let pattern = StripePattern(color1: white, color2: black)
        
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 0, z: 0)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 1, z: 0)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 2, z: 0)), white)
    }
    
    // p. 129
    func testStripePatternConstInZ() throws {
        let pattern = StripePattern(color1: white, color2: black)
        
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 0, z: 0)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 0, z: 1)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 0, z: 2)), white)
    }
    
    // p. 129
    func testStripePatternAlternatesInX() throws {
        let pattern = StripePattern(color1: white, color2: black)
        
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0, y: 0, z: 0)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 0.9, y: 0, z: 0)), white)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: 1, y: 0, z: 0)), black)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: -0.1, y: 0, z: 0)), black)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: -1.0, y: 0, z: 0)), black)
        XCTAssertEqual(pattern.colorAt(point: Tuple.makePoint(x: -1.1, y: 0, z: 0)), white)
    }
    
    // p. 129
    func testLightingWithPatternApplied() throws {
        let pattern = StripePattern(color1: white, color2: black)
        var m = Material()
        m.ambient = 1
        m.diffuse = 0
        m.specular = 0
        m.pattern = pattern
        let eyeVec = Tuple.makeVector(x: 0, y: 0, z: -1)
        let normalVec = Tuple.makeVector(x: 0, y: 0, z: -1)
        let light = PointLight(position: Tuple.makePoint(x: 0, y: 0, z: -10), color: white)
        
        let c1 = m.lighting(light: light, position: Tuple.makePoint(x: 0.9, y: 0, z: 0), eyeVec: eyeVec, normalVec: normalVec, inShadow: false)
        let c2 = m.lighting(light: light, position: Tuple.makePoint(x: 1.1, y: 0, z: 0), eyeVec: eyeVec, normalVec: normalVec, inShadow: false)
        
        XCTAssertEqual(c1, white)
        XCTAssertEqual(c2, black)
    }
}
