//
//  main.swift
//  Tracer
//
//  Created by Bastian Hundt on 19.09.21.
//

import Foundation

// p. 13
func chapOnePlayground() {
    var proj = Projectile(position: Tuple.makePoint(x: 0, y: 1, z: 0),
                          velocity: Tuple.makeVector(x: 1, y: 1, z: 0))
    let env = Environment(gravity: Tuple.makeVector(x: 0, y: -0.1, z: 0),
                          wind: Tuple.makeVector(x: -0.01, y: 0, z: 0))

    while proj.pos.y > 0 {
        proj = tick(environment: env, projectile: proj)
        print("Current Projectile Position: (\(proj.pos.x), \(proj.pos.y), \(proj.pos.z))")
    }
}

// p. 22
func chapTwoPlayground() {
    let canvas = Canvas(width: 1920, height: 1080)
    var proj = Projectile(position: Tuple.makePoint(x: 0, y: 1, z: 0),
                          velocity: Tuple.makeVector(x: 1, y: 1.5, z: 0).getNormalized() * 10)
    let env = Environment(gravity: Tuple.makeVector(x: 0, y: -0.1, z: 0),
                          wind: Tuple.makeVector(x: -0.01, y: 0, z: 0))

    while proj.pos.y > 0 {
        canvas[Int(proj.pos.x.rounded()), canvas.height - Int(proj.pos.y.rounded()) - 1] = Color(red: 1, green: 1, blue: 1)
        proj = tick(environment: env, projectile: proj)
        print("Current Projectile Position: (\(proj.pos.x), \(proj.pos.y), \(proj.pos.z))")
    }
    
    let ppm = canvas.toPortablePixMap()
    
    let path = FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0].appendingPathComponent("traj.ppm")
    
    do {
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

// p. 55
func chapThreePlayground() {
    let canvas = Canvas(width: 200, height: 200)
    
    let center = Tuple.makePoint(x: 75, y: 0, z: 0)
    let clockPositions: [Double] = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330].map { $0 * Double.pi/180  }
    
    for angle in clockPositions {
        let drawPix = (Matrix.makeIdentity(size: 4).rotateZ(radians: angle)) * center
        canvas[Int(drawPix.x.rounded())+100, canvas.height - Int(drawPix.y.rounded()) - 100] = Color(red: 1, green: 1, blue: 1)
    }
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("clock.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}


/// First try, this is not rendered from one perspective
func chapFourPlaygroundOne() {
    let canvas = Canvas(width: 100, height: 100)
    let canvasCenterW = canvas.width / 2
    let canvasCenterH = canvas.height / 2
    let s = Sphere(trafo: Matrix.makeIdentity(size: 4)
                    .scale(x: 10, y: 10, z: 10)
                    .translate(x: Double(canvasCenterW),
                               y: Double(canvasCenterH),
                               z: 0))
    
    for w in 0..<canvas.width {
        for h in 0..<canvas.height {
            let ray = Ray(origin: Tuple.makePoint(x: Double(w),
                                                  y: Double(h),
                                                  z: -1),
                          direction: Tuple.makeVector(x: 0, y: 0, z: 1))
            let xs = ray.intersect(sphere: s)
            let hits = xs.hit()

            if hits != nil {
                print("HIT! x: \(w) y: \(h)")
                canvas[w, h] = Color(red: 1, green: 0, blue: 0)
            }
        }
    }
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("sphere2d.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

/// Solution according to book
func chapFourPlaygroundTwo() {
    let rayOrigin = Tuple.makePoint(x: 0, y: 0, z: -5)
    let wallZ = 10.0
    let wallSize = 7.0
    
    let canvasPixels = 100
    let pixelSize = wallSize / Double(canvasPixels)
    let half = wallSize / 2.0
    
    let canvas = Canvas(width: canvasPixels, height: canvasPixels)
    let color = Color(red: 1, green: 0, blue: 0)
    let shape = Sphere()
    
    for y in 0..<canvasPixels {
        let worldY = half - pixelSize * Double(y)
        for x in 0..<canvasPixels {
            let worldX = -half + pixelSize * Double(x)
            let position = Tuple.makePoint(x: worldX, y: worldY, z: wallZ)
            let r = Ray(origin: rayOrigin, direction: (position-rayOrigin).normalized)
            let xs = r.intersect(sphere: shape)
            if xs.hit() != nil {
                canvas[x, y] = color
            }
            
        }
    }
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("sphere2d.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

chapFourPlaygroundTwo()
