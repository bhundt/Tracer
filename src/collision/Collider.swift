//
//  Collider.swift
//  Tracer
//
//  Created by Bastian Hundt on 29.09.21.
//

import Foundation

class Collider {
    static func intersect(ray: Ray, withSphere: Sphere) -> (Intersection?, Intersection?) {
        let ray2 = ray.transform(trafo: withSphere.transform.inversed) // we transform back to a unit sphere centered at 0,0,0
        
        let sphereToRay = ray2.origin - Tuple.makePoint(x: 0, y: 0, z: 0)
        let a = ray2.direction.dot(withVector: ray2.direction)
        let b = 2 * ray2.direction.dot(withVector: sphereToRay)
        let c = sphereToRay.dot(withVector: sphereToRay) - 1
        let dsc = pow(b, 2.0) - 4 * a * c
        
        if dsc < 0 {
            return (nil, nil)
        }
        
        let t1 = (-b - dsc.squareRoot()) / (2 * a)
        let t2 = (-b + dsc.squareRoot()) / (2 * a)
        
        return (Intersection(t: t1, obj: withSphere), Intersection(t: t2, obj: withSphere))
    }
    
    static func intersect(ray: Ray, withWorld: World) -> [Intersection] {
        var intersections: [Intersection] = []
        for obj in withWorld.objects {
            switch obj {
                case let sphere as Sphere:
                    let (i1, i2) = self.intersect(ray: ray, withSphere: sphere)
                    if let int1 = i1 { intersections.append(int1) }
                    if let int2 = i2 { intersections.append(int2) }
                default:
                    break
            }
        }
        return intersections.sorted()
    }
}

/// These extension help using an array of intersections
extension Array where Element == Intersection {
    /// Sort the intetrsections by ascending t-value
    mutating func sort() {
        self.sort(by: { $0.t < $1.t })
    }
    
    /// Returns a sorted version of the intersections
    func sorted() -> Array {
        return self.sorted(by: { $0.t < $1.t })
    }
    
    /// Finds the nearest hit from the ray. Nearest means smallest, non-negative t-value
    func hit() -> Intersection? {
        let hits = self.sorted().filter({ elem in elem.t >= 0.0 })
        if hits.count > 0 {
            return hits.first
        }
        return nil
    }

}
