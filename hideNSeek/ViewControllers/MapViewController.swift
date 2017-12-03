//
//  MapViewController.swift
//  hideNSeek
//
//  Created by Jeffrey Lam on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    var mapView: GMSMapView!
    var room: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        locationManager!.delegate = self
        currentLocation = locationManager.location
        
        let coordinates = currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 35.300347, longitude: -120.662285)
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: zoomLevel)

        /* Setting up Google Map View */
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view = mapView
        
        updateMarkers()
    }
    
    func updateMarkers() {
        if (self.isViewLoaded) {
            mapView.clear()
            
            for player in room!.getPlayers() {
                if (player.name != room!.currentPlayer!.name) {
                    let position = player.getCoordinate()
                    let marker = GMSMarker(position: position)
                    marker.map = self.mapView
                    marker.appearAnimation = GMSMarkerAnimation.pop
                    print ("marked")
                }
            }
        }
    }
    
}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print ("*** Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        mapView.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print ("Location access was restricted.")
        case .denied:
            print ("User denied access to location.")
        case .notDetermined:
            print ("Location status is not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print ("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print ("Error: \(error)")
    }
}
