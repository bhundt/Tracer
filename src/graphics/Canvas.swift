//
//  Canvas.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

class Canvas {
    var pixels: [[Color]]  = []
    
    init(width: Int, height: Int) {
        assert(width > 0); assert(height > 0)
        self.w = width
        self.h = height
        
        pixels = Array(repeating: Array(repeating: Color(red: 0, green: 0, blue: 0), count: height), count: width)
    }
    private var w: Int
    private var h: Int
    
    var width: Int {get{return w}}
    var height: Int {get{return h}}
    
    subscript(indexX: Int, indexY: Int) -> Color {
        get {
            assert(indexX < width); assert(indexX >= 0); assert(indexY < height); assert(indexX >= 0)
            return pixels[indexX][indexY]
        }
        set(newColor) {
            assert(indexX < width); assert(indexX >= 0); assert(indexY < height); assert(indexX >= 0)
            pixels[indexX][indexY] = newColor
        }
    }
    
    func toPortablePixMap() -> String {
        var export: [String] = []
        
        func makePpmHeader() -> [String] {
            var header: [String] = []
            header.append("P3")
            header.append("\(width) \(height)")
            header.append("255")
            return header
        }
        
        export.append(contentsOf: makePpmHeader())
        
        for row in 0..<height {
            export.append("")
            for col in 0..<width {
                let cappedColor = pixels[col][row].getCappped()
                
                let redComponent = "\( Int((cappedColor.red * 255).rounded()) )"
                if (export[export.count-1].count + redComponent.count) > 70 {
                    export[export.count-1] = String( export[export.count-1].dropLast() )
                    export.append(redComponent + " ")
                } else {
                    export[export.count-1].append(redComponent + " ")
                }
                
                let greenComponent = "\( Int((cappedColor.green * 255).rounded()) )"
                if (export[export.count-1].count + greenComponent.count) > 70 {
                    export[export.count-1] = String( export[export.count-1].dropLast() )
                    export.append(greenComponent + " ")
                } else {
                    export[export.count-1].append(greenComponent + " ")
                }
                
                let blueComponent = "\( Int((cappedColor.blue * 255).rounded()) )"
                if (export[export.count-1].count + blueComponent.count) > 70 {
                    export[export.count-1] = String( export[export.count-1].dropLast() )
                    export.append(blueComponent + " ")
                } else {
                    export[export.count-1].append(blueComponent + " ")
                }
            }
            export[export.count-1] = String( export[export.count-1].dropLast() ) // dropLast is necessary since we add a space to every color entry
        }
        
        return export.joined(separator: "\n").appending("\n")
    }
}
