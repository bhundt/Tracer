//
//  WorldTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 28.09.21.
//

import XCTest

class WorldTest: XCTestCase {
    // p. 92
    func testWorldExists() throws {
        let w = World()
        XCTAssertEqual( w.objects.count, 0 )
        XCTAssertEqual( w.lights.count, 0 )
    }
    
    // p. 92
    func testCreateDefaultWorld() throws {
        let w = World.makeDefaultWorld()

        XCTAssertEqual(w.objects.count, 2)
        XCTAssert(w.objects[0] is Sphere)
        XCTAssert(w.objects[1] is Sphere)
        
        XCTAssertEqual(w.lights.count, 1)
        XCTAssert(w.lights[0] is PointLight)
        
        let s1 = w.objects[0] as! Sphere
        let s2 = w.objects[1] as! Sphere
        let light = w.lights[0] as! PointLight
        
        XCTAssertEqual(s1.material.color, Color(red: 0.8, green: 1.0, blue: 0.6))
        XCTAssertEqual(s1.material.diffuse, 0.7)
        XCTAssertEqual(s1.material.specular, 0.2)
        
        XCTAssertEqual(s2.transform, Matrix4.makeIdentity().scale(x: 0.5, y: 0.5, z: 0.5))
        
        XCTAssertEqual(light.color, Color(red: 1.0, green: 1.0, blue: 1.0))
        XCTAssertEqual(light.position, Tuple.makePoint(x: -10, y: 10, z: -10))
    }
    
    // p. 92
    func testIntersectRayWithWorld() throws {
        let w = World.makeDefaultWorld()
        let ray = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        
        //let xs = ray.intersect(world: w)
        let xs = Collider.intersect(ray: ray, withWorld: w)
        
        XCTAssertEqual(xs.count, 4)
        XCTAssertEqual(xs[0].t, 4.0)
        XCTAssertEqual(xs[1].t, 4.5)
        XCTAssertEqual(xs[2].t, 5.5)
        XCTAssertEqual(xs[3].t, 6.0)
    }
    
    
    
    // p. 114
    func testShadeHitIsGivenIntersectionInShadow() throws {
        let w = World()
        w.lights.append( PointLight(position: Tuple.makePoint(x: 0, y: 0, z: -16), color: Color(red: 1, green: 1, blue: 1)) )
        
        let s1 = Sphere()
        w.objects.append(s1)
        
        let s2 = Sphere()
        s2.transform = Matrix4.makeTranslation(x: 0, y: 0, z: 10)
        w.objects.append(s2)
        
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: 5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let i = Intersection(t: 4.0, obj: s2)
        
        let comps = i.prepareComputation(ray: r)
        let c = Renderer.shadeHit(comps: comps, world:w)
        
        XCTAssertEqual(c, Color(red: 0.1, green: 0.1, blue: 0.1))        
    }
}
