//
//  Shape.swift
//  Tracer
//
//  Created by Bastian Hundt on 03.10.21.
//

import Foundation

protocol Shape: IdentifiableObject {
    var uniqueId: UUID { get }
    
    var transform: Matrix4 {get set}
    var material: Material {get set}
    
    /// Returns intersections of ray with Shape. To be implemented by every concrete shape; assumes ray is transformed to local coordiantes. Use intersect() with Ray in world coordiantes.
    func localIntersect(withRay ray: Ray) -> [Intersection]
    
    /// Returns the (normalized) normal vector at given point. Point is assumed to be in local coordinates. Use normal() with point in world coordincates.
    func localNormal(atPoint point: Tuple) -> Tuple
}

extension Shape {
    func intersect(withRay ray: Ray) -> [Intersection] {
        let localRay = ray.transform(trafo: self.transform.inversed)
        return self.localIntersect(withRay: localRay)
    }
    
    func normalVec(atPoint point: Tuple) -> Tuple {
        let localPoint = transform.inversed * point
        let localNormal = localNormal(atPoint: localPoint)
        var worldNormal = transform.inversed.transposed * localNormal
        
        worldNormal.w = 0.0
        return worldNormal.normalized
    }
}
