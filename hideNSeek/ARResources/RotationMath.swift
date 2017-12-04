//
//  RotationMath.swift
//  hideNSeek
//
//  Created by CheckoutUser on 12/2/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//
//  Math provided by https://medium.com/journey-of-one-thousand-apps/arkit-and-corelocation-part-two-7b045fb1d7a1

import Foundation
import CoreLocation

extension Double {
    func toRadians () -> Double {
        return self * .pi / 180.0
    }
    
    func toDegrees () -> Double {
        return self * 180.0 / .pi
    }
}

let metersPerRadianLat: Double = 6373000.0
let metersPerRadianLon: Double = 5602900.0

extension CLLocationCoordinate2D {
    func calculateBearing(to coordinate: CLLocationCoordinate2D) -> Double {
        let a = sin(coordinate.longitude.toRadians() - longitude.toRadians()) * cos(coordinate.latitude.toRadians())
        let b = cos(latitude.toRadians()) * sin(coordinate.latitude.toRadians()) - sin(latitude.toRadians()) * cos(coordinate.latitude.toRadians()) * cos(coordinate.longitude.toRadians() - longitude.toRadians())
        return atan2(a, b)
    }
    
    func direction(to coordinate: CLLocationCoordinate2D) -> CLLocationDirection {
        return self.calculateBearing(to: coordinate).toDegrees()
    }
    
    func coordinate(with bearing: Double, and distance: Double) -> CLLocationCoordinate2D {
        
        let distRadiansLat = distance / metersPerRadianLat  // earth radius in meters latitude
        let distRadiansLong = distance / metersPerRadianLon // earth radius in meters longitude
        
        let lat1 = self.latitude.toRadians()
        let lon1 = self.longitude.toRadians()
        
        let lat2 = asin(sin(lat1) * cos(distRadiansLat) + cos(lat1) * sin(distRadiansLat) * cos(bearing))
        let lon2 = lon1 + atan2(sin(bearing) * sin(distRadiansLong) * cos(lat1), cos(distRadiansLong) - sin(lat1) * sin(lat2))
        
        return CLLocationCoordinate2D(latitude: lat2.toDegrees(), longitude: lon2.toDegrees())
    }
}
