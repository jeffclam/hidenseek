//
//  Player.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Player {
    var name: String
    var latitude: Double
    var longitude: Double
    var isHider: Bool
    let ref: DatabaseReference?
    
    init (name: String, latitude: Double, longitude: Double, isHider: Bool) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isHider = isHider
        ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        name = snapshot.key
        let snapvalues = snapshot.value as! [String : AnyObject]
        print ("snapvalues in \(name): \(snapvalues)")
        latitude = snapvalues["latitude"] as! Double
        longitude = snapvalues["longitude"] as! Double
        isHider = snapvalues["isHider"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "latitude" : latitude,
            "longitude" : longitude,
            "isHider" : isHider
        ]
    }
}
