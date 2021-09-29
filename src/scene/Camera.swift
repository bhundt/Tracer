//
//  Camera.swift
//  Tracer
//
//  Created by Bastian Hundt on 28.09.21.
//

import Foundation

class Camera {
    var _horizontalSize: Int
    var _verticalSize: Int
    var _fov: Double
    var _transform: Matrix4
    var _pixelSize: Double = 0
    var _aspect: Double = 0
    var _halfView: Double = 0
    var _halfWidth: Double = 0
    var _halfHeight: Double = 0
    
    init(horizontalSize: Int, verticalSize: Int, fov: Double) {
        self._horizontalSize = horizontalSize
        self._verticalSize = verticalSize
        self._fov = fov
        self._transform = Matrix4.makeIdentity()
        
        calcProperties()
    }
    
    var horizontalSize: Int {get {return _horizontalSize}}
    var verticalSize: Int {get {return _verticalSize}}
    var fov: Double {get {return _fov}}
    var transform: Matrix4 {get {return _transform} set(t) {_transform = t}}
    var pixelSize: Double {get {return _pixelSize}}
    var aspect: Double {get {return _aspect}}
    var halfView: Double {get {return _halfView}}
    var halfWidth: Double {get {return _halfWidth}}
    var halfHeight: Double {get {return _halfHeight}}
    
    func rayForPixel(x: Int, y: Int) -> Ray {
        let xOffset = (Double(x) + 0.5) * pixelSize
        let yOffset = (Double(y) + 0.5) * pixelSize
        
        let worldX = halfWidth - xOffset
        let worldY = halfHeight - yOffset
        
        let pixel = transform.inversed * Tuple.makePoint(x: worldX, y: worldY, z: -1)
        let origin = transform.inversed * Tuple.makePoint(x: 0, y: 0, z: 0)
        let direction = (pixel-origin).normalized
        
        return Ray(origin: origin, direction: direction)
    }
    
    private func calcProperties() {
        _halfView = tan(_fov/2)
        _aspect = Double(_horizontalSize)/Double(_verticalSize)
        
        if _aspect >= 1 {
            _halfWidth = _halfView
            _halfHeight = _halfView / _aspect
        } else {
            _halfWidth = _halfView * _aspect
            _halfHeight = _halfView
        }
        _pixelSize = (_halfWidth * 2) / Double(_horizontalSize)
    }
}
