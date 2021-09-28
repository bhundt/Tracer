//
//  PointLight.swift
//  Tracer
//
//  Created by Bastian Hundt on 23.09.21.
//

import Foundation

class PointLight: IdentifiableObject, Equatable {
    private var _id: UUID
    var uniqueId: UUID { get {return _id}}
    
    var position: Tuple
    var color: Color
    
    init(position: Tuple, color: Color) {
        _id = UUID()
        
        self.position = position
        self.color = color
    }
    
    static func == (lhs: PointLight, rhs: PointLight) -> Bool {
        return (lhs.uniqueId == rhs.uniqueId)
    }
}
