//
//  Object.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation


/// This protocol represents any object in the world which needs to be uniquely identified
protocol IdentifiableObject {
    var uniqueId: UUID { get }
}

/// This protocol represents any object in the world with which rays can collide
protocol CollidableObject {
    func normal(at: Tuple) -> Tuple
}

/// This protocol represents any object in the world which can be shaded
protocol ShadeableObject {
    var material: Material {get set}
}
