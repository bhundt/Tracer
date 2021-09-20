//
//  Matrix.swift
//  Tracer
//
//  Created by Bastian Hundt on 20.09.21.
//

import Foundation

struct Matrix {
    var m: [[Double]] = []
    var rows: Int {get{return _rows}}
    var columns: Int {get{return _columns}}
    
    private var _rows: Int
    private var _columns: Int
    
    
    init(rows: Int, columns: Int) {
        self._rows = rows
        self._columns = columns
        m = Array(repeating: Array(repeating: 0.0, count: columns), count: rows)
    }
    
    var transposed: Matrix {
        get {
            var R = Matrix(rows: self.columns, columns: self.rows)
            for r in 0..<R.rows {
                for c in 0..<R.columns {
                    R[r, c] = self[c, r]
                }
            }
            return R
        }
    }
    
    subscript(row: Int, col: Int) -> Double {
        get {
            return m[row][col]
        }
        set(val) {
            m[row][col] = val
        }
    }
    
    static func makeIdentity(size: Int) -> Matrix {
        var M = Matrix(rows: size, columns: size)
        for n in 0..<size {
            M[n, n] = 1.0
        }
        return M
    }
    
    static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.columns == rhs.rows)
        let vecLen = lhs.columns
        
        var result = Matrix(rows: lhs.rows, columns: rhs.columns)
        for r in 0..<result.rows {
            for c in 0..<result.columns {
                for l in 0..<vecLen {
                    result[r, c] += lhs[r, l] * rhs[l, c]
                }
                
            }
        }
        return result
    }
    
    static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        assert(lhs.rows == rhs.rows)
        assert(lhs.columns == rhs.columns)
        var equal: Bool = true
        
        for r in 0..<lhs.rows {
            for c in 0..<lhs.columns {
                if lhs[r, c] != rhs[r, c] {
                    equal = false
                }
            }
        }
        
        return equal
    }
    
    static func != (lhs: Matrix, rhs: Matrix) -> Bool {
        return !(lhs == rhs)
    }
}

func *<T: TupleProtocol> (lhs: Matrix, rhs: T) -> T {
    var M = Matrix(rows: 4 , columns: 1)
    M[0, 0] = rhs.x
    M[1, 0] = rhs.y
    M[2, 0] = rhs.z
    M[3, 0] = rhs.w
    let R = lhs * M
    
    return T(x: R[0, 0], y: R[1, 0], z: R[2, 0], w: R[3, 0])
}
