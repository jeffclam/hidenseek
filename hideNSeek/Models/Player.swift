//
//  Player.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

class Player {
    var name: String
    var latitude: Double
    var longitude: Double
    var isHider: Bool
    
    init (name: String, latitude: Double, longitude: Double, isHider: Bool) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isHider = isHider
    }
    
    init (name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.latitude = coordinates.latitude
        self.longitude = coordinates.longitude
        self.isHider = Bool(truncating: arc4random_uniform(2) as NSNumber)
    }
    
    init(snapshot: DataSnapshot) {
        name = snapshot.key
        let snapvalues = snapshot.value as! [String : AnyObject]
        print ("snapvalues in \(name): \(snapvalues)")
        latitude = snapvalues["latitude"] as! Double
        longitude = snapvalues["longitude"] as! Double
        isHider = snapvalues["isHider"] as! Bool
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toString() -> String {
        return "\(name): \(self.toAnyObject())"
    }
    
    func toAnyObject() -> Any {
        return [
            "latitude" : latitude,
            "longitude" : longitude,
            "isHider" : isHider
        ]
    }
}
