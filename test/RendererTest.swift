//
//  RendererTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 30.09.21.
//

import XCTest

class RendererTest: XCTestCase {
    // p. 111
    func testNoShadowWhenNotingBetweenLightAndPoint() throws {
        let w = World.makeDefaultWorld()
        let p = Tuple.makePoint(x: 0, y: 10, z: 0)
        XCTAssertFalse(Renderer.isPointInShadow(world:w, point: p))
    }

    // p. 112
    func testShadowWhenObjectBetweenLightAndPoint() throws {
        let w = World.makeDefaultWorld()
        let p = Tuple.makePoint(x: 10, y: -10, z: 10)
        XCTAssertTrue(Renderer.isPointInShadow(world:w, point: p))
    }
    
    // p. 112
    func testNoShadowWhenObjectBehindLight() throws {
        let w = World.makeDefaultWorld()
        let p = Tuple.makePoint(x: -20, y: 20, z: -20)
        XCTAssertFalse(Renderer.isPointInShadow(world:w, point: p))
    }
    
    // p. 112
    func testNoShadowWhenObjectBehindPoint() throws {
        let w = World.makeDefaultWorld()
        let p = Tuple.makePoint(x: -2, y: 2, z: -2)
        XCTAssertFalse(Renderer.isPointInShadow(world:w, point: p))
    }
}
