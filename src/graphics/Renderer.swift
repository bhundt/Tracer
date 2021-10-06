//
//  Renderer.swift
//  Tracer
//
//  Created by Bastian Hundt on 29.09.21.
//

import Foundation

/// Helper to chunk an array into bits
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

/// Settings for the renderer
struct RenderSettings {
    var shadows: Bool = true
    var clearColor: Color = Color(red: 0, green: 0, blue: 0)
    var multithreaded: Bool = true
    var numberOfChunks: Int = 4
}

class Renderer {
    private var settings: RenderSettings
    
    init(settings: RenderSettings = RenderSettings()) {
        self.settings = settings
    }
    
    /// Main function to create a Ray-Traced image
    static func render(camera: Camera, world: World) -> Canvas {
        let methodStart = Date()
        
        // resulting image
        let image = Canvas(width: camera.horizontalSize, height: camera.verticalSize)
        
        // our "thread-pool" for rendering chunks of the image
        let renderQueue = OperationQueue()
        renderQueue.name = "me.hundt.tracer.renderQueue"
        renderQueue.qualityOfService = .userInitiated
        
        // array holding individual render operations
        var renderOperations: [BlockOperation] = []
        
        // we use the lockQueue to circumvent race conditions on image outpur data structure
        let lockQueue = DispatchQueue(label: "me.hundt.tracer.lockQueue", qos: .userInitiated)
        
        // we chunk in y-directions
        let chunkSize = Int(camera.verticalSize/6)
        let yChunks = Array(0..<camera.verticalSize).chunked(into: chunkSize > 0 ? chunkSize : 1)
    
        // every chunk is rendered on its individual "thread"
        for chunk in yChunks {
            let renderOperation = BlockOperation {
                let chunkStart = Date()
                
                // FIX: this costs us "a little memory" since we are only using a subpart in each renderOperation
                let tempCanvas = Canvas(width: camera.horizontalSize, height: camera.verticalSize)
                
                // render chunk
                for y in chunk {
                    for x in 0 ..< camera.horizontalSize {
                        let ray = camera.rayForPixel(x: x, y: y)
                        let color = Renderer.colorAt(ray: ray, world: world)
                        tempCanvas[x, y] = color
                    }
                }
                
                // sync image into output structure
                lockQueue.sync {
                    for y in chunk {
                        for x in 0 ..< camera.horizontalSize {
                            image[x, y] = tempCanvas[x, y]
                        }
                    }
                }
                
                let chhunkExecutionTime = Date().timeIntervalSince(chunkStart)
                print("Rendering time: \(chhunkExecutionTime) on thread \(Thread.current)")
            }
            
            renderOperations.append(renderOperation)
        }
        
        
        // start rendering
        renderQueue.addOperations(renderOperations, waitUntilFinished: true)
        
        let executionTime = Date().timeIntervalSince(methodStart)
        print("Total rendering time: \(executionTime)")
        
        return image
    }
    
    /// Helper to get the final color of the World for the given Ray
    static func colorAt(ray: Ray, world: World) -> Color {
        let intersections = world.intersect(withRay: ray)
        
        if let i = intersections.hit() {
            let comps = i.prepareComputation(ray: ray)
            return shadeHit(comps: comps, world: world)
        } else {
            return Color(red: 0, green: 0, blue: 0)
        }
    }
    
    /// Helper to calculate the color of the hit using material
    static func shadeHit(comps: ShadingHelperData, world: World) -> Color {
        // FIX: as! PointLight
        // FIX: multiple lights
        let shadowed = Renderer.isPointInShadow(world: world, point: comps.overPoint)
        return comps.object.material.lighting(light: world.lights[0] as! PointLight, position: comps.point, eyeVec: comps.eyeVec, normalVec: comps.normalVec, inShadow: shadowed)
    }
    
    /// Helper to determine whether a point in the scene is in shadow
    static func isPointInShadow(world: World, point: Tuple) -> Bool {
        assert(point.isPoint)
        
        // FIX: multiple light
        // FIX: as! PointLight
        
        let v = (world.lights[0] as! PointLight).position - point
        let distance = v.length
        let direction = v.normalized
        
        let r = Ray(origin: point, direction: direction)
        let xs = world.intersect(withRay: r)
        let h = xs.hit()
        if let hit = h {
            if hit.t < distance {
                return true
            }
        }
        
        return false
    }
}

