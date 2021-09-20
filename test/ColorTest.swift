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
}
