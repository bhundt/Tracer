//
//  Renderer.swift
//  Tracer
//
//  Created by Bastian Hundt on 29.09.21.
//

import Foundation

struct RenderSettings {
    var shadows: Bool = true
}

class Renderer {
    static func render(camera: Camera, world: World, settings: RenderSettings = RenderSettings()) -> Canvas {
        let methodStart = Date()
        
        let image = Canvas(width: camera.horizontalSize, height: camera.verticalSize)
        for y in 0 ..< camera.verticalSize {
            for x in 0 ..< camera.horizontalSize {
                let ray = camera.rayForPixel(x: x, y: y)
                let color = world.colorAt(ray: ray)
                image[x, y] = color
            }
        }
        
        let executionTime = Date().timeIntervalSince(methodStart)
        print("Rendering time: \(executionTime)")
        
        return image
    }
    
    static func isPointInShadow(world: World, point: Tuple) -> Bool {
        assert(point.isPoint)
        
        let v = (world.lights[0] as! PointLight).position - point
        let distance = v.length
        let direction = v.normalized
        
        let r = Ray(origin: point, direction: direction)
        let xs = Collider.intersect(ray: r, withWorld: world)
        let h = xs.hit()
        if let hit = h {
            if hit.t < distance {
                return true
            }
        }
        
        return false
    }
}
