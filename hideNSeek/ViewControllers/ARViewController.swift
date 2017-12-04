//
//  ARViewController.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

class ARViewController: UIViewController {
    var arrow : Arrow?
    
    @IBOutlet weak var arView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConfiguration()
        addArrowToScene()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScene() {
        let scene = SCNScene()
        arView.scene = scene
    }
    
    func setupConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
    }
    
    func addArrowToScene() {
        
        let location = CLLocation(latitude: 35.300297, longitude: -120.662252)
        let startingLocation = CLLocation(latitude: 35.30044247949112, longitude: -120.67702236241747)
        let locationTransform = MatrixHelper.transformMatrix(for: matrix_identity_float4x4, originLocation: startingLocation, location: location)
        let anchor = ARAnchor(transform: locationTransform)
 
        arrow = Arrow()
        arrow!.location = startingLocation
        arrow!.anchor = anchor
        arrow!.loadModel()
        arView.scene.rootNode.addChildNode(arrow!)
    }
}
