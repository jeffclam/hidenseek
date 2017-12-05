//
//  MasterTabVC.swift
//  hideNSeek
//
//  Created by Jeffrey Lam on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import CoreLocation

class MasterTabVC: UITabBarController {
    var room: Room!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mapVC = viewControllers![0] as! MapViewController
        mapVC.locationManager = locationManager
        mapVC.room = room
        room.getPlayersFromDB(closure: {
            mapVC.updateMarkers()
        })
        
        let chatNavVC = viewControllers![1] as! ChatNavController
        chatNavVC.room = room
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
