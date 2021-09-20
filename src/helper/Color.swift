//
//  Color.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

struct Color: TupleProtocol {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
    var w: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.x = red
        self.y = green
        self.z = blue
        self.w = 0.0
    }
    
    var red: Double {
        get {
            return x
        }
        set(r) {
            x = r
        }
    }
    
    var green: Double {
        get {
            return y
        }
        set(g) {
            y = g
        }
    }
    
    var blue: Double {
        get {
            return z
        }
        set(b) {
            z = b
        }
    }
}
