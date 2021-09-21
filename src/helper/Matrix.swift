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
    
    init(size: Int) {
        self.init(rows: size, columns: size)
    }
    
    /// Initializes matrix with every component being zero
    /// - Parameters:
    ///   - rows: number of rows
    ///   - columns: number of columns
    init(rows: Int, columns: Int) {
        self._rows = rows
        self._columns = columns
        m = Array(repeating: Array(repeating: 0.0, count: columns), count: rows)
    }
    
    
    /// Returns the transposed version of the matrix
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
    
    var inversed: Matrix {
        get {
            assert(invertible)
            
            var M2 = Matrix(rows: self.rows, columns: self.columns)
            for r in 0..<self.rows {
                for c in 0..<self.columns {
                    let cf = cofactor(row: r, col: c)
                    M2[c, r] = cf / determinant
                }
            }
            return M2
        }
    }
    
    var determinant: Double {
        get {
            assert( self.rows == self.columns )
            var det = 0.0
            
            if self.columns == 2 && self.rows == 2 {
                det = self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
            } else {
                for c in 0..<self.columns {
                    det = det + m[0][c] * cofactor(row: 0, col: c)
                }
            }
            return det
        }
    }
    
    var invertible: Bool {
        get {
            assert( self.rows == self.columns )
            return !(self.determinant == 0)
        }
    }
    
    func submatrix(row: Int, col: Int) -> Matrix {
        assert(row >= 0)
        assert(col >= 0)
        assert(row < self.rows)
        assert(col < self.columns)
        assert(rows >= 3)
        assert(columns >= 3)
        
        // these hold the indices into the original matrix
        var rangeRows = [Int](0..<rows)
        var rangeCols = [Int](0..<columns)
        
        // here we remove the row and columns which should be removed to create the submatrix
        rangeRows.remove(at: row)
        rangeCols.remove(at: col)
        
        var M = Matrix(rows: self.rows-1, columns: self.columns-1)
        for r in 0..<M.rows {
            for c in 0..<M.columns {
                M[r, c] = m[ rangeRows[r] ][ rangeCols[c] ]
            }
        }
        
        return M
    }
    
    func minor(row: Int, col: Int) -> Double {
        assert(row >= 0)
        assert(col >= 0)
        assert(row < self.rows)
        assert(col < self.columns)
        
        let M = self.submatrix(row: row, col: col)
        return M.determinant
    }
    
    func cofactor(row: Int, col: Int) -> Double {
        assert(row >= 0)
        assert(col >= 0)
        assert(row < self.rows)
        assert(col < self.columns)
        
        var m = minor(row: row, col: col)
        if (row + col) % 2 == 1 {
            // odd number
            m = -m
        }
        return m
    }
    
    subscript(row: Int, col: Int) -> Double {
        get {
            assert(row >= 0)
            assert(col >= 0)
            assert(row < self.rows)
            assert(col < self.columns)
            return m[row][col]
        }
        set(val) {
            assert(row >= 0)
            assert(col >= 0)
            assert(row < self.rows)
            assert(col < self.columns)
            m[row][col] = val
        }
    }
    
    
    /// Creates a square matrix with 1.0 on the diagonal
    /// - Parameter size: The number of rows / columns
    /// - Returns: The identity matrix
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


/// Multiplies a 4-component Tuple with a Matrix
/// - Parameters:
///   - lhs: The Matrix
///   - rhs: The Tuple
/// - Returns: The resulting Tuple
func *<T: TupleProtocol> (lhs: Matrix, rhs: T) -> T {
    assert(lhs.rows == 4)
    
    var M = Matrix(rows: 4 , columns: 1)
    M[0, 0] = rhs.x
    M[1, 0] = rhs.y
    M[2, 0] = rhs.z
    M[3, 0] = rhs.w
    let R = lhs * M
    
    return T(x: R[0, 0], y: R[1, 0], z: R[2, 0], w: R[3, 0])
}
