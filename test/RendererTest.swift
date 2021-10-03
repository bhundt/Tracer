//
//  RendererTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 30.09.21.
//

import XCTest

class RendererTest: XCTestCase {
    // p. 95
    func testShadeIntersection() throws {
        let w = World.makeDefaultWorld()
        let ray = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let shape = w.objects[0]
        let i = Intersection(t: 4.0, obj: shape)
        
        let comps = i.prepareComputation(ray: ray)
        let c = Renderer.shadeHit(comps: comps, world: w)
        
        XCTAssertEqual(c, Color(red: 0.38066, green: 0.47583, blue: 0.2855))
    }
    
    // p. 95
    func testShadeIntersectionFromInside() throws {
        let w = World.makeDefaultWorld()
        let ray = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 0), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        w.lights[0] = PointLight(position: Tuple.makePoint(x: 0, y: 0.25, z: 0), color: Color(red: 1, green: 1, blue: 1))
        let shape = w.objects[1]
        let i = Intersection(t: 0.5, obj: shape)
        
        let comps = i.prepareComputation(ray: ray)
        let c = Renderer.shadeHit(comps: comps, world: w)
        
        XCTAssertEqual(c, Color(red: 0.90498, green: 0.90498, blue: 0.90498))
    }
    
    // p. 96
    func testColorRayMisses() throws {
        let w = World.makeDefaultWorld()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 1, z: 0))
        
        let c = Renderer.colorAt(ray: r, world: w)
        XCTAssertEqual(c, Color(red: 0, green: 0, blue: 0))
    }
    
    // p. 96
    func testColorRayHits() throws {
        let w = World.makeDefaultWorld()
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        
        let c = Renderer.colorAt(ray: r, world: w)
        XCTAssertEqual(c, Color(red: 0.38066, green: 0.47583, blue: 0.2855))
    }
    
    // p. 97
    func testColorWithIntersectionBehindRay() throws {
        let w = World.makeDefaultWorld()
        w.objects[0].material.ambient = 1.0
        w.objects[1].material.ambient = 1.0
        
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 0.75), direction: Tuple.makeVector(x: 0, y: 0, z: -1))
        
        let c = Renderer.colorAt(ray: r, world: w)
        XCTAssertEqual(c, w.objects[1].material.color)
    }
    
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
    
    // prepare multithreaded renderer
    func testSplitArrayIntoChunks() throws {
        let arr = Array(0..<10)
        let chunkArray = arr.chunked(into: 2)
        
        XCTAssertEqual(chunkArray.count, 5)
        XCTAssertEqual(chunkArray[0].count, 2)
        XCTAssertEqual(chunkArray[1].count, 2)
        XCTAssertEqual(chunkArray[2].count, 2)
        XCTAssertEqual(chunkArray[3].count, 2)
        XCTAssertEqual(chunkArray[4].count, 2)
    }
    
    // prepare multithreaded renderer
    func testSplitArrayIntoChunksWithModulo() throws {
        let arr = Array(0..<11)
        let chunkArray = arr.chunked(into: 5)
        
        XCTAssertEqual(chunkArray.count, 3)
        XCTAssertEqual(chunkArray[0].count, 5)
        XCTAssertEqual(chunkArray[1].count, 5)
        XCTAssertEqual(chunkArray[2].count, 1)
    }
}
