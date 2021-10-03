//
//  ShapeTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 03.10.21.
//

import XCTest

class TestShape: Shape {
    private var _id: UUID = UUID()
    var uniqueId: UUID { get {return _id} }
    
    var transform: Matrix4 = Matrix4.makeIdentity()
    var material: Material = Material()
    
    var resultingRay: Ray = Ray(origin: Tuple.makePoint(x: 999, y: 999, z: 999), direction: Tuple.makeVector(x: 999, y: 999, z: 999))
    
    func localIntersect(withRay ray: Ray) -> [Intersection] {
        resultingRay = ray
        return []
    }
    
    func localNormal(atPoint point: Tuple) -> Tuple {
        return Tuple.makeVector(x: point.x, y: point.y, z: point.z)
    }
}

class ShapeTest: XCTestCase {
    // p. 119
    func testShapeHasDefaultTranformation() throws {
        let s = TestShape()
        XCTAssertEqual(s.transform, Matrix4.makeIdentity())
    }
    
    // p. 119
    func testShapeCanAssignTransformation() throws {
        let s = TestShape()
        s.transform = Matrix4.makeTranslation(x: 2, y: 3, z: 4)
        XCTAssertEqual(s.transform, Matrix4.makeTranslation(x: 2, y: 3, z: 4))
    }
    
    // p. 119
    func testShapeHasMaterial() throws {
        let s = TestShape()
        XCTAssertEqual(s.material, Material())
    }
    
    // p. 119
    func testShapeCanChangeMaterial() throws {
        let s = TestShape()
        var m = Material()
        m.ambient = 1
        s.material = m
        XCTAssertEqual(s.material, m)
    }
    
    // p. 120
    func testIntersectingScaledShapeWithRay () throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = TestShape()
        
        s.transform = Matrix4.makeScaling(x: 2, y: 2, z: 2)
        let _ = s.intersect(withRay: r)
        
        XCTAssertEqual(s.resultingRay.origin, Tuple.makePoint(x: 0, y: 0, z: -2.5))
        XCTAssertEqual(s.resultingRay.direction, Tuple.makeVector(x: 0, y: 0, z: 0.5))
    }
    
    // p. 120
    func testIntersectingTranslatedShapeWithRay () throws {
        let r = Ray(origin: Tuple.makePoint(x: 0, y: 0, z: -5), direction: Tuple.makeVector(x: 0, y: 0, z: 1))
        let s = TestShape()
        
        s.transform = Matrix4.makeTranslation(x: 5, y: 0, z: 0)
        let _ = s.intersect(withRay: r)
        
        XCTAssertEqual(s.resultingRay.origin, Tuple.makePoint(x: -5, y: 0, z: -5))
        XCTAssertEqual(s.resultingRay.direction, Tuple.makeVector(x: 0, y: 0, z: 1))
    }
    
    // p. 121
    func testComputingNormalTranslatedShape() throws {
        let s = TestShape()
        s.transform = Matrix4.makeTranslation(x: 0, y: 1, z: 0)
        
        let n = s.normalVec(atPoint: Tuple.makePoint(x: 0, y: 1.70711, z: -0.70711))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.70711, z: -0.70711))
    }
    
    // p. 121
    func testComputingNormalTransformedShape() throws {
        let s = TestShape()
        s.transform = Matrix4.makeIdentity().rotateZ(radians: Double.pi/5).scale(x: 1, y: 0.5, z: 1)
        
        let n = s.normalVec(atPoint: Tuple.makePoint(x: 0, y: 2.squareRoot()/2, z: -1*2.squareRoot()/2))
        XCTAssertEqual(n, Tuple.makeVector(x: 0, y: 0.97014, z: -0.24254))
    }
}
