//
//  Renderer.swift
//  Tracer
//
//  Created by Bastian Hundt on 29.09.21.
//

import Foundation

class Renderer {
    static func render(camera: Camera, world: World) -> Canvas {
        let methodStart = Date()
        
        let image = Canvas(width: camera.horizontalSize, height: camera.verticalSize)
        for y in 0 ..< camera.verticalSize {
            for x in 0 ..< camera.horizontalSize {
                let ray = camera.rayForPixel(x: x, y: y)
                let color = world.colorAt(ray: ray)
                image[x, y] = color
            }
        }
        
        let methodFinish = Date()
        let executionTime = methodFinish.timeIntervalSince(methodStart)
        print("Rendering time: \(executionTime)")
        
        return image
    }
}
