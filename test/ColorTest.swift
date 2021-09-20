//
//  ColorTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 20.09.21.
//

import XCTest

class ColorTest: XCTestCase {
    // p. 16
    func testColorExists() throws {
        let c = Color(red: -0.5, green: 0.4, blue: 1.7)
        XCTAssertEqual(c.red, -0.5)
        XCTAssertEqual(c.green, 0.4)
        XCTAssertEqual(c.blue, 1.7)
    }
    
    // p. 17
    func testAddColors() throws {
        let c1 = Color(red: 0.9, green: 0.6, blue: 0.75)
        let c2 = Color(red: 0.7, green: 0.1, blue: 0.25)
        XCTAssertEqual(c1 + c2, Color(red: 1.6, green: 0.7, blue: 1.0))
    }
    
    // p. 17
    func testSubColors() throws {
        let c1 = Color(red: 0.9, green: 0.6, blue: 0.75)
        let c2 = Color(red: 0.7, green: 0.1, blue: 0.25)
        XCTAssertEqual(c1 - c2, Color(red: 0.20000000000000007, green: 0.5, blue: 0.5))
    }
    
    // p. 17
    func testMultColorByScalar() throws {
        let c = Color(red: 0.2, green: 0.3, blue: 0.4)
        XCTAssertEqual(c * 2, Color(red: 0.4, green: 0.6, blue: 0.8))
    }
    
    // p. 17
    func testMultColors() throws {
        let c1 = Color(red: 1.0, green: 0.2, blue: 0.4)
        let c2 = Color(red: 0.9, green: 1.0, blue: 0.1)
        XCTAssertEqual(c1 * c2, Color(red: 0.9, green: 0.2, blue: 0.04000000000000001))
    }
}
