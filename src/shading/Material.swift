//
//  Material.swift
//  Tracer
//
//  Created by Bastian Hundt on 23.09.21.
//

import Foundation

struct Material: Equatable {
    var color = Color(red: 1, green: 1, blue: 1)
    var ambient: Double = 0.1
    var diffuse: Double = 0.9
    var specular: Double = 0.9
    var shininess: Double = 200.0
    var pattern: Pattern?
    
    /// Calculates Phong shading
    func lighting(light: PointLight, position: Tuple, eyeVec: Tuple, normalVec: Tuple, inShadow: Bool) -> Color{
        assert(position.isPoint); assert(eyeVec.isVector); assert(normalVec.isVector)
        
        var myColor = self.color
        
        if let pattern = pattern {
            myColor = pattern.colorAt(point: position)
        }
        
        let effColor = myColor * light.color
        
        let amb = effColor * self.ambient
        if inShadow { // when we are in shadow we only are lit by ambient light
            return amb
        }
        
        let lightVec = (light.position - position).normalized
        
        var dif = Color(red: 0, green: 0, blue: 0)
        var spec = Color(red: 0, green: 0, blue: 0)
        
        let lightDotNormal = lightVec.dot(withVector: normalVec)
        if lightDotNormal >=  0 {
            dif = effColor * self.diffuse * lightDotNormal
            let reflectV = (-lightVec).reflect(normal: normalVec)
            let reflectDotEye = reflectV.dot(withVector: eyeVec)
            
            if reflectDotEye > 0 {
                let factor = pow(reflectDotEye, self.shininess)
                spec = light.color * self.specular * factor
            }
            
        }
        
        return amb + dif + spec
    }
    
    static func == (lhs: Material, rhs: Material) -> Bool {
        return ((lhs.color == rhs.color) &&
                (lhs.ambient == rhs.ambient) &&
                (lhs.diffuse == rhs.diffuse) &&
                (lhs.specular == rhs.specular) &&
                (lhs.shininess == rhs.shininess))
    }
}
