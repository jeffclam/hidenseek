//
//  MatrixHelper.swift
//  hideNSeek
//
//
//  Pulled from https://medium.com/journey-of-one-thousand-apps/arkit-and-corelocation-part-two-7b045fb1d7a1
//

import Foundation

import CoreLocation
import GLKit.GLKMatrix4
import SceneKit

class MatrixHelper {
    
    //    column 0  column 1  column 2  column 3
    //         1        0         0       X          x        x + X*w 
    //         0        1         0       Y      x   y    =   y + Y*w 
    //         0        0         1       Z          z        z + Z*w 
    //         0        0         0       1          w           w    
    
    static func translationMatrix(with matrix: matrix_float4x4, for translation : vector_float4) -> matrix_float4x4 {
        var matrix = matrix
        matrix.columns.3 = translation
        return matrix
    }
    
    //    column 0  column 1  column 2  column 3
    //        cosθ      0       sinθ      0    
    //         0        1         0       0    
    //       −sinθ      0       cosθ      0    
    //         0        0         0       1    
    
    static func rotateAroundY(with matrix: matrix_float4x4, for degrees: Float) -> matrix_float4x4 {
        var matrix : matrix_float4x4 = matrix
        
        matrix.columns.0.x = cos(degrees)
        matrix.columns.0.z = -sin(degrees)
        
        matrix.columns.2.x = sin(degrees)
        matrix.columns.2.z = cos(degrees)
        return matrix.inverse
    }
    
    static func transformMatrix(for matrix: simd_float4x4, originLocation: CLLocation, location: CLLocation) -> simd_float4x4 {
        //let distance = Float(location.distance(from: originLocation))
        let bearing = GLKMathDegreesToRadians(Float(originLocation.coordinate.direction(to: location.coordinate)))
        //let position = vector_float4(0.0, 0.0, -distance, 0.0)
        /*
        let translationMatrix = MatrixHelper.translationMatrix(with: matrix_identity_float4x4, for: position)
 */
        let translationMatrix = matrix_identity_float4x4
        let rotationMatrix = MatrixHelper.rotateAroundY(with: matrix_identity_float4x4, for: bearing)
        let transformMatrix = simd_mul(rotationMatrix, translationMatrix)
        return simd_mul(matrix, transformMatrix)
    }
}
