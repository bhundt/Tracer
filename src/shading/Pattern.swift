//
//  Pattern.swift
//  Tracer
//
//  Created by Bastian Hundt on 05.10.21.
//

import Foundation

/// A color pattern on a Shape
protocol Pattern {
    var transform: Matrix4 {get set}
    
    func colorAt(point: Tuple) -> Color
}
