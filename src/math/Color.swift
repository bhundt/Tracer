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
    
    init(x: Double, y: Double, z: Double, w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
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
    
    func getCappped() -> Color {
        var r = red
        var g = green
        var b = blue
        if r > 1.0 { r = 1.0 }
        if r < 0.0 { r = 0.0 }
        if g > 1.0 { g = 1.0 }
        if g < 0.0 { g = 0.0 }
        if b > 1.0 { b = 1.0 }
        if b < 0.0 { b = 0.0 }
        
        return Color(red: r, green: g, blue: b)
    }
    
    static func *(lhs: Color, rhs: Color) -> Color {
        return Color(red: lhs.red*rhs.red,
                     green: lhs.green*rhs.green,
                     blue: lhs.blue*rhs.blue)
    }
}
