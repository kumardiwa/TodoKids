//
//  LocationTracker.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import CoreLocation
enum DKLocationStatus {
    case access,noAccess,notEnable
}
protocol LocationTrackerDelegate : class
{
    func didUpdateLocation(_location : CLLocation)
}
class LocationTracker: NSObject,CLLocationManagerDelegate {
    class var shared: LocationTracker {
        struct Static {
            static let instance = LocationTracker()
        }
        return Static.instance
    }
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
       // manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    var coordinate : CLLocationCoordinate2D?{
        get{
            return CLLocationCoordinate2D(latitude: latitude ?? 0.00, longitude: longitude ?? 0.00)
        }
    }
    var latitude : CLLocationDegrees?
    var longitude : CLLocationDegrees?
    var delegate : LocationTrackerDelegate?
    var isLocationAvailable : Bool?{
        get{
            if latitude == nil || longitude == nil {
                return false
            }
            else{
                return true
            }
        }
    
        
    }
    
    func startUpdatingLocation(){
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
        guard let mostRecentLocation = locations.last else {
            return
        }
        self.latitude = mostRecentLocation.coordinate.latitude
        self.longitude = mostRecentLocation.coordinate.longitude
        self.delegate?.didUpdateLocation(_location: mostRecentLocation)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        //
    }
    func checkLocationStatus() -> DKLocationStatus{
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return .noAccess
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return .access
            }
        } else {
            print("Location services are not enabled")
            return .notEnable
        }
    }
   
}
