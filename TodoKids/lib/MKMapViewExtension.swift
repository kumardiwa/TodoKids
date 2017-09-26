//
//  MKMapViewExtension.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 23/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
extension MKMapView
{
    func setCenterRegion(_ coord : CLLocationCoordinate2D)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var mapRegion = MKCoordinateRegion(center: coord, span: span)
        mapRegion = self.regionThatFits(mapRegion)
        self.setRegion(mapRegion, animated: true)
    }
    func zoomLavel() -> Double {
        // function returns current zoom of the map
        var angleCamera = self.camera.heading
        if angleCamera > 270 {
            angleCamera = 360 - angleCamera
        } else if angleCamera > 90 {
            angleCamera = fabs(angleCamera - 180)
        }
        let angleRad = Double.pi * angleCamera / 180 // camera heading in radians
        let width = Double(self.frame.size.width)
        let height = Double(self.frame.size.height)
        let heightOffset : Double = 20 // the offset (status bar height) which is taken by MapKit into consideration to calculate visible area height
        // calculating Longitude span corresponding to normal (non-rotated) width
        let spanStraight = width * self.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
        return log2(360 * ((width / 256) / spanStraight)) + 1;
    }
}
