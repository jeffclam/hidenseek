//
//  Arrow.swift
//  hideNSeek
//
//  Created by CheckoutUser on 12/2/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
import CoreLocation

class Arrow : SCNNode {
    var anchor : ARAnchor? {
        didSet {
            guard let transform = anchor?.transform else { return }
            self.position = positionFromTransform(transform)
        }
    }
    
    var location : CLLocation!
    
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "arrow.dae") else { return }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
    
    func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        
        //    column 0  column 1  column 2  column 3
        //         1        0         0       X    
        //         0        1         0       Y    
        //         0        0         1       Z    
        //         0        0         0       1    
        
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
}
