//
//  World.swift
//  Tracer
//
//  Created by Bastian Hundt on 28.09.21.
//

import Foundation

class World {
    var objects: [IdentifiableObject & CollidableObject & ShadeableObject] = []
    var lights: [IdentifiableObject] = []
    
    func shadeHit(comps: PrecomputeData) -> Color {
        // FIX: as! PointLight
        return (comps.object as! ShadeableObject).material.lighting(light: self.lights[0] as! PointLight, position: comps.point, eyeVec: comps.eyeVec, normalVec: comps.normalVec)
    }
    
    func colorAt(ray: Ray) -> Color {
        let intersections = ray.intersect(world: self)
        
        if let i = intersections.hit() {
            let comps = i.prepareComputation(ray: ray)
            return shadeHit(comps: comps)
        } else {
            return Color(red: 0, green: 0, blue: 0)
        }
    }
    
    static func makeDefaultWorld() -> World {
        let w = World()
        let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
        
        let s1 = Sphere()
        s1.material.color = Color(red: 0.8, green: 1.0, blue: 0.6)
        s1.material.diffuse = 0.7
        s1.material.specular = 0.2
        
        let s2 = Sphere(trafo: Matrix4.makeIdentity().scale(x: 0.5, y: 0.5, z: 0.5))
        
        w.lights.append(light)
        w.objects.append(s1)
        w.objects.append(s2)
        return w
    }
}