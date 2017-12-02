//
//  MasterTabVC.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import CoreLocation

class MasterTabVC: UITabBarController {
    var room: Room?
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print ("\(room!.name)")
        print ("roomService made it to MasterTabVC")
        let mapVC = viewControllers![0] as! MapViewController
        print ("*** location manager not set yet")
        mapVC.locationManager = locationManager
        print ("*** location manager set in selectedViewController")
        /* else if let viewController = selectedViewController as? ChatViewController {
            
        } else if let viewController = selectedViewController as? ARViewController {
            
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
