//
//  Intersection.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

/// Description
class Intersection: Equatable {
    var t: Double     // the intersection along a ray
    var object: Any   // the object the ray intersected with
    
    init(t: Double, obj: Any) {
        self.object = obj
        self.t = t
    }
    
    static func == (lhs: Intersection, rhs: Intersection) -> Bool {
        return ((lhs.object as! IdentifiableObject).uniqueId == (rhs.object as! IdentifiableObject).uniqueId) && (lhs.t == rhs.t)
    }
}

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
