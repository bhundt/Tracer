//
//  StripePattern.swift
//  Tracer
//
//  Created by Bastian Hundt on 05.10.21.
//

import Foundation

struct StripePattern: Pattern {
    var transform: Matrix4 = Matrix4.makeIdentity()
    
    var a: Color
    var b: Color
    
    init(color1: Color, color2: Color) {
        a = color1
        b = color2
    }
    
    func colorAt(point: Tuple) -> Color {
        if Int(floor(point.x)) % 2 == 0 {
            return a
        } else {
            return b
        }
    }
}
