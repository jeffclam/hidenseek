//
//  ARViewController.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var arView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScene () {
        let scene = SCNScene()
        arView.scene = scene
    }
    
    
}
