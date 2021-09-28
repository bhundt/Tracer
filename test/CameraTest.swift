//
//  CameraTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 28.09.21.
//

import XCTest

class CameraTest: XCTestCase {
    // p. 101
    func testConstructCam() throws {
        let c = Camera(horizontalSize: 160, verticalSize: 120, fov: Double.pi/2)
        XCTAssertEqual(c.horizontalSize, 160)
        XCTAssertEqual(c.verticalSize, 120)
        XCTAssertEqual(c.fov, Double.pi/2)
        XCTAssertEqual(c.transform, Matrix4.makeIdentity())
    }

    // p. 101
    func testPixelSizeHor() throws {
        let c = Camera(horizontalSize: 200, verticalSize: 125, fov: Double.pi/2)
        XCTAssertEqual(c.pixelSize, 0.009999999999999998)
    }
    
    // p. 101
    func testPixelSizeVer() throws {
        let c = Camera(horizontalSize: 125, verticalSize: 200, fov: Double.pi/2)
        XCTAssertEqual(c.pixelSize, 0.009999999999999998)
    }
    
    // p. 103
    func testConstructRayThroughCenter() throws {
        let c = Camera(horizontalSize: 201, verticalSize: 101, fov: Double.pi/2)
        let r = c.rayForPixel(x: 100, y: 50)
        XCTAssertEqual(r.origin, Tuple.makePoint(x: 0, y: 0, z: 0))
        XCTAssertEqual(r.direction, Tuple.makeVector(x: 0, y: 0, z: -1))
    }
    
    // p. 103
    func testConstructRayThroughEdge() throws {
        let c = Camera(horizontalSize: 201, verticalSize: 101, fov: Double.pi/2)
        let r = c.rayForPixel(x: 0, y: 0)
        XCTAssertEqual(r.origin, Tuple.makePoint(x: 0, y: 0, z: 0))
        XCTAssertEqual(r.direction, Tuple.makeVector(x: 0.66519, y: 0.33259, z: -0.66851))
    }
    
    // p. 103
    func testConstructRayThroughTransformedCam() throws {
        let c = Camera(horizontalSize: 201, verticalSize: 101, fov: Double.pi/2)
        c.transform = Matrix4.makeIdentity().translate(x: 0, y: -2, z: 5).rotateY(radians: Double.pi/4)
        
        let r = c.rayForPixel(x: 100, y: 50)
        XCTAssertEqual(r.origin, Tuple.makePoint(x: 0, y: 2, z: -5))
        XCTAssertEqual(r.direction, Tuple.makeVector(x: 2.0.squareRoot()/2, y: 0.0, z: -2.0.squareRoot()/2))
    }
    
    // p. 104
    func testRenderWorldWithCamera() throws {
        let w = World.makeDefaultWorld()
        let c = Camera(horizontalSize: 11, verticalSize: 11, fov: Double.pi/2)
        let from = Tuple.makePoint(x: 0, y: 0, z: -5)
        let to = Tuple.makePoint(x: 0, y: 0, z: 0)
        let up = Tuple.makeVector(x: 0, y: 1, z: 0)
        
        c.transform = Matrix4.makeviewTransform(from: from, to: to, up: up)
        
        let image = c.render(world: w)
        XCTAssertEqual(image[5, 5], Color(red: 0.38066, green: 0.47583, blue: 0.2855))
    }
}

