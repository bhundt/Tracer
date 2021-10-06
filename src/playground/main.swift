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
                                        in:.userDomainMask)[0].appendingPathComponent("traj.ppm")
    
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
        let drawPix = (Matrix4.makeIdentity().rotateZ(radians: angle)) * center
        canvas[Int(drawPix.x.rounded())+100, canvas.height - Int(drawPix.y.rounded()) - 100] = Color(red: 1, green: 1, blue: 1)
    }
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("clock.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}


/// First try, this is not rendered from one perspective und results in wrond image
func chapFivePlaygroundOne() {
    let canvas = Canvas(width: 100, height: 100)
    let canvasCenterW = canvas.width / 2
    let canvasCenterH = canvas.height / 2
    let s = Sphere(trafo: Matrix4.makeIdentity()
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
            //let xs = ray.intersect(sphere: s)
            //let xs = Collider.intersect(ray: ray, withSphere: s)
            let xs = s.intersect(withRay: ray)
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
                                            in:.userDomainMask)[0].appendingPathComponent("sphere2d.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

/// Solution according to book
func chapFivePlaygroundTwo() {
    let methodStart = Date()
    let rayOrigin = Tuple.makePoint(x: 0, y: 0, z: -5)
    let wallZ = 10.0
    let wallSize = 7.0
    
    let canvasPixels = 200
    let pixelSize = wallSize / Double(canvasPixels)
    let half = wallSize / 2.0
    
    let canvas = Canvas(width: canvasPixels, height: canvasPixels)
    let color = Color(red: 1, green: 0, blue: 0)
    let shape = Sphere(trafo: Matrix4.makeIdentity()
                        .scale(x: 1, y: 0.5, z: 1)
                        .rotateZ(radians: Double.pi/4))
    
    for y in 0..<canvasPixels {
        let worldY = half - pixelSize * Double(y)
        for x in 0..<canvasPixels {
            let worldX = -half + pixelSize * Double(x)
            let position = Tuple.makePoint(x: worldX, y: worldY, z: wallZ)
            let r = Ray(origin: rayOrigin, direction: (position-rayOrigin).normalized)
            let xs = shape.intersect(withRay: r)
            if xs.hit() != nil {
                canvas[x, y] = color
            }
            
        }
    }
    
    let methodFinish = Date()
    let executionTime = methodFinish.timeIntervalSince(methodStart)
    print("Rendering time: \(executionTime)")
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("sphere2d.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

/// Solution according to book but parallelized
func chapFivePlaygroundThree() {
    
}

/// Solution according to book
func chapSixPlayground() {
    let methodStart = Date()
    let rayOrigin = Tuple.makePoint(x: 0, y: 0, z: -5)
    let wallZ = 10.0
    let wallSize = 7.0
    
    let canvasPixels = 500
    let pixelSize = wallSize / Double(canvasPixels)
    let half = wallSize / 2.0
    
    let lightPosition = Tuple.makePoint(x: -10, y: 10, z: -10)
    let lightColor = Color(red: 1, green: 1, blue: 1)
    let light = PointLight(position: lightPosition, color: lightColor)
    
    let canvas = Canvas(width: canvasPixels, height: canvasPixels)
    //let shape = Sphere(trafo: Matrix4.makeIdentity())
    var shape = Sphere(trafo: Matrix4.makeIdentity()
                        //.scale(x: 1, y: 0.5, z: 1)
                        //.rotateZ(radians: -Double.pi/4)
                        )
    shape.material.color = Color(red: 0.1, green: 0.5, blue: 0.8)
    //shape.material.shininess = 150
    //shape.material.diffuse = 0.9
    //shape.material.ambient = 0.3
    //shape.material.specular = 0.4
    
    for y in 0..<canvasPixels {
        let worldY = half - pixelSize * Double(y)
        for x in 0..<canvasPixels {
            let worldX = -half + pixelSize * Double(x)
            let position = Tuple.makePoint(x: worldX, y: worldY, z: wallZ)
            let r = Ray(origin: rayOrigin, direction: (position-rayOrigin).normalized)
            
            //let xs = r.intersect(sphere: shape)
            //let xs = Collider.intersect(ray: r, withSphere: shape)
            let xs = shape.intersect(withRay: r)
            if  let hit = xs.hit() {
                let hitSphere = hit.object as! Sphere
                let point = r.position(t: hit.t)
                let normal = hitSphere.normalVec(atPoint: point)
                let eye = -(r.direction)
                
                canvas[x, y] = hitSphere.material.lighting(light: light, position: point, eyeVec: eye, normalVec: normal, inShadow: false) //+ hitSphere.material.lighting(light: light2, position: point, eyeVec: eye, normalVec: normal)
            }
            
        }
    }
    
    let methodFinish = Date()
    let executionTime = methodFinish.timeIntervalSince(methodStart)
    print("Rendering time: \(executionTime)")
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("sphere3d.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

func chapSevenPlayground() {
    var floor = Sphere()
    floor.transform = Matrix4.makeScaling(x: 10, y: 0.01, z: 10)
    floor.material.color = Color(red: 0.9, green: 0.9, blue: 0.9)
    floor.material.specular = 0
    floor.material.ambient = 0.2
    
    var leftWall = Sphere()
    leftWall.transform = Matrix4.makeScaling(x: 10, y: 0.01, z: 10).rotateX(radians: Double.pi/2).rotateY(radians: -Double.pi/4).translate(x: 0, y: 0, z: 5)
    leftWall.material.color = Color(red: 0.9, green: 0.9, blue: 0.9)
    leftWall.material.ambient = 0.7
    
    var rightWall = Sphere()
    rightWall.transform = Matrix4.makeScaling(x: 10, y: 0.01, z: 10).rotateX(radians: Double.pi/2).rotateY(radians: Double.pi/4).translate(x: 0, y: 0, z: 5)
    rightWall.material.color = Color(red: 0.7, green: 0.7, blue: 0.85)
    
    var middle = Sphere()
    middle.transform = Matrix4.makeTranslation(x: -0.5, y: 1, z: 0.5)
    middle.material.color = Color(red: 0.1, green: 1, blue: 0.5)
    middle.material.diffuse = 0.7
    middle.material.specular = 0.3
    
    var right = Sphere()
    right.transform = Matrix4.makeTranslation(x: 1.5, y: 0.5, z: -0.5) * Matrix4.makeScaling(x: 0.5, y: 0.5, z: 0.5)
    right.material.color = Color(red: 0.5, green: 1, blue: 0.1)
    right.material.diffuse = 0.7
    right.material.specular = 0.3
    
    var left = Sphere()
    left.transform = Matrix4.makeTranslation(x: -1.5, y: 0.33, z: -0.75) * Matrix4.makeScaling(x: 0.33, y: 0.33, z: 0.33)
    left.material.color = Color(red: 1, green: 0.8, blue: 0.1)
    left.material.diffuse = 0.7
    left.material.specular = 0.3
    
    let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
    
    let camera = Camera(horizontalSize: 1920, verticalSize: 1080, fov: Double.pi/3)
    camera.transform = Matrix4.makeviewTransform(from: Tuple.makePoint(x: 0, y: 1.5, z: -5), to: Tuple.makePoint(x: 0, y: 1, z: 0), up: Tuple.makeVector(x: 0, y: 1, z: 0)).rotateY(radians: Double.pi/32)
    
    let w = World()
    w.objects.append(contentsOf: [middle, left, right, leftWall, rightWall, floor])
    w.lights.append(light)
    
    let canvas = Renderer.render(camera: camera, world: w)
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("scene.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

func chapEightPlayground() {
    var floor = Plane()
    floor.material.color = Color(red: 0.9, green: 0.9, blue: 0.9)
    floor.material.specular = 0
    floor.material.ambient = 0.2
    
    var middle = Sphere()
    middle.transform = Matrix4.makeTranslation(x: -0.5, y: 1, z: 0.5)
    middle.material.color = Color(red: 0.1, green: 1, blue: 0.5)
    middle.material.diffuse = 0.7
    middle.material.specular = 0.3
    
    var right = Sphere()
    right.transform = Matrix4.makeTranslation(x: 1.5, y: 0.5, z: -0.5) * Matrix4.makeScaling(x: 0.5, y: 0.5, z: 0.5)
    right.material.color = Color(red: 0.5, green: 1, blue: 0.1)
    right.material.diffuse = 0.7
    right.material.specular = 0.3
    
    var left = Sphere()
    left.transform = Matrix4.makeTranslation(x: -1.5, y: 0.33, z: -0.75) * Matrix4.makeScaling(x: 0.33, y: 0.33, z: 0.33)
    left.material.color = Color(red: 1, green: 0.8, blue: 0.1)
    left.material.diffuse = 0.7
    left.material.specular = 0.3
    
    let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
    
    let camera = Camera(horizontalSize: 480*2, verticalSize: 270*2, fov: Double.pi/3)
    camera.transform = Matrix4.makeviewTransform(from: Tuple.makePoint(x: 0, y: 1.5, z: -5), to: Tuple.makePoint(x: 0, y: 1, z: 0), up: Tuple.makeVector(x: 0, y: 1, z: 0))//.rotateY(radians: Double.pi/32)
    
    let w = World()
    w.objects.append(contentsOf: [middle, left, right])
    w.objects.append(floor)
    w.lights.append(light)
    
    let canvas = Renderer.render(camera: camera, world: w)
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("scene_plane.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

func chapNinePlayground() {
    var floor = Plane()
    floor.material.color = Color(red: 0.9, green: 0.9, blue: 0.9)
    floor.material.specular = 0
    floor.material.ambient = 0.2
    
    var middle = Sphere()
    middle.transform = Matrix4.makeTranslation(x: -0.5, y: 1, z: 0.5)
    middle.material.color = Color(red: 0.1, green: 1, blue: 0.5)
    middle.material.diffuse = 0.7
    middle.material.specular = 0.3
    middle.material.pattern = StripePattern(color1: Color(red: 0.1, green: 0.8, blue: 0.1), color2: Color(red: 0.05, green: 0.4, blue: 0.05))
    
    var right = Sphere()
    right.transform = Matrix4.makeTranslation(x: 1.5, y: 0.5, z: -0.5) * Matrix4.makeScaling(x: 0.5, y: 0.5, z: 0.5)
    right.material.color = Color(red: 0.5, green: 1, blue: 0.1)
    right.material.diffuse = 0.7
    right.material.specular = 0.3
    
    var left = Sphere()
    left.transform = Matrix4.makeTranslation(x: -1.5, y: 0.33, z: -0.75) * Matrix4.makeScaling(x: 0.33, y: 0.33, z: 0.33)
    left.material.color = Color(red: 1, green: 0.8, blue: 0.1)
    left.material.diffuse = 0.7
    left.material.specular = 0.3
    
    let light = PointLight(position: Tuple.makePoint(x: -10, y: 10, z: -10), color: Color(red: 1, green: 1, blue: 1))
    
    let camera = Camera(horizontalSize: 480*2, verticalSize: 270*2, fov: Double.pi/3)
    camera.transform = Matrix4.makeviewTransform(from: Tuple.makePoint(x: 0, y: 1.5, z: -5), to: Tuple.makePoint(x: 0, y: 1, z: 0), up: Tuple.makeVector(x: 0, y: 1, z: 0))//.rotateY(radians: Double.pi/32)
    
    let w = World()
    w.objects.append(contentsOf: [middle, left, right])
    w.objects.append(floor)
    w.lights.append(light)
    
    let canvas = Renderer.render(camera: camera, world: w)
    
    let ppm = canvas.toPortablePixMap()
    do {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in:.userDomainMask)[0].appendingPathComponent("scene_plane_pat.ppm")
        try ppm.write(to: path, atomically: false, encoding: .utf8)
    }
    catch {}
}

//chapOnePlayground()
//chapTwoPlayground()
//chapThreePlayground()
//chapFivePlaygroundTwo()
//chapSixPlayground()
//chapSevenPlayground()
//chapEightPlayground()
chapNinePlayground()
