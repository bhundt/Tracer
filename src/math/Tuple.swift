//
//  Tuple.swift
//  Tracer
//
//  Created by Bastian Hundt on 19.09.21.
//

import Foundation

struct Tuple: TupleProtocol {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
    var w: Double
    
    init(x: Double, y: Double, z: Double, w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    var isPoint: Bool {
        get {
            return fabs(w - 1.0) < COMPARE_EPSILON
            
        }
    }
    var isVector: Bool {
        get {
            return fabs(w - 0.0) < COMPARE_EPSILON
            
        }
    }
    
    var normalized: Tuple { get {return getNormalized()} }
    
    func getNormalized() -> Tuple {
        let l = length
        assert(l > 0.0)
        return Tuple(x: x/l, y: y/l, z: z/l, w: w/l)
    }
    
    func dot(withVector: Tuple) -> Double {
        return x*withVector.x + y*withVector.y + z*withVector.z + w*withVector.w
    }
    
    func cross(withVector: Tuple) -> Tuple {
        return Tuple(x: y*withVector.z - z*withVector.y,
                     y: z*withVector.x - x*withVector.z,
                     z: x*withVector.y - y*withVector.x,
                     w: 0.0)
    }
    
    func reflect(normal: Tuple) -> Tuple {
        return self - normal * 2 * self.dot(withVector: normal)
    }
    
    static func makePoint(x: Double, y: Double, z: Double) -> Tuple {
        return Tuple(x: x, y: y, z: z, w: 1.0)
    }
    
    static func makeVector(x: Double, y: Double, z: Double) -> Tuple {
        return Tuple(x: x, y: y, z: z, w: 0.0)
    }
}
