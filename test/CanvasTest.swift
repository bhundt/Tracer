//
//  CanvasTest.swift
//  TracerTest
//
//  Created by Bastian Hundt on 20.09.21.
//

import XCTest

class CanvasTest: XCTestCase {
    // p. 19
    func testCreateCanvas() throws {
        let c = Canvas(width: 10, height: 20)
        XCTAssertEqual(c.width, 10)
        XCTAssertEqual(c.height, 20)
        for x in 0..<c.width {
            for y in 0..<c.height {
                XCTAssertEqual(c[x, y], Color(red: 0, green: 0, blue: 0))
            }
        }
    }
    
    // p. 19
    func testWritePixel() throws {
        let c = Canvas(width: 10, height: 20)
        let red = Color(red: 1, green: 0, blue: 0)
        c[2, 3] = red
        XCTAssertEqual(c[2, 3], Color(red: 1, green: 0, blue: 0))
    }
    
    // p. 21
    func testCanvasToPpmHeader() throws {
        let c = Canvas(width: 5, height: 3)
        let ppm = c.toPortablePixMap()
        
        let lines = ppm.components(separatedBy: "\n")
        XCTAssertEqual(lines[0], "P3")
        XCTAssertEqual(lines[1], "5 3")
        XCTAssertEqual(lines[2], "255")
    }
    
    // p. 21
    func testCanvasToPpmWithPixelData() throws {
        let c = Canvas(width: 5, height: 3)
        let c1 = Color(red: 1.5, green: 0, blue: 0)
        let c2 = Color(red: 0, green: 0.5, blue: 0)
        let c3 = Color(red: -0.5, green: 0, blue: 1)
        
        c[0, 0] = c1
        c[2, 1] = c2
        c[4, 2] = c3
        
        let ppm = c.toPortablePixMap()
        let lines = ppm.components(separatedBy: "\n")
        XCTAssertEqual(lines[3], "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0")
        XCTAssertEqual(lines[4], "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0")
        XCTAssertEqual(lines[5], "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255")
    }
 
    // p. 22
    func testCanvasToPpmLongLines() throws {
        let c = Canvas(width: 10, height: 2)
        
        for x in 0..<c.width {
            for y in 0..<c.height {
                c[x, y] = Color(red: 1, green: 0.8, blue: 0.6)
            }
        }
        
        let ppm = c.toPortablePixMap()
        
        let lines = ppm.components(separatedBy: "\n")
        XCTAssertEqual(lines[3], "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204")
        XCTAssertEqual(lines[4], "153 255 204 153 255 204 153 255 204 153 255 204 153")
        XCTAssertEqual(lines[5], "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204")
        XCTAssertEqual(lines[6], "153 255 204 153 255 204 153 255 204 153 255 204 153")
    }
    
    // p. 22
    func testCanvasToPpmEofCorrect() throws {
        let c = Canvas(width: 5, height: 3)
        let ppm = c.toPortablePixMap()
        
        XCTAssertEqual(ppm.last!, "\n")
    }
}
