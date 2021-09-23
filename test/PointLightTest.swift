//
//  PointLightTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 23.09.21.
//

import XCTest

class PointLightTest: XCTestCase {
    // p. 84
    func testPointLightHasPosAndInt() throws {
        let intensity = Color(red: 1, green: 1, blue: 1)
        let pos = Tuple.makePoint(x: 0, y: 0, z: 0)
        let light = PointLight(position: pos, color: intensity)
        XCTAssertEqual(light.position, pos)
        XCTAssertEqual(light.color, intensity)
    }
    
    // p. 
}
