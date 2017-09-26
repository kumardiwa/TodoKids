//
//  MyLocationViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 23/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MyLocationViewController: UIViewController,MKMapViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var placeArray : [DKGooglePlace]! = []
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        self.checkLocation()

        // Do any additional setup after loading the view.
    }
    //MARK: - Setup Layouts
    func setupLayouts()
    {
        setupMapView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.title = "Your Location"
    }
    func setupMapView()
    {
        mapView?.showsUserLocation = true
        // locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - Actions & Methods
    func getAddress(_ coordinate : CLLocationCoordinate2D){
        DKGoogleClass.shared.getAddress(coordinate) { (address, error, country, postalCode, title) in
            if error == nil{
                self.lblLocation.text = address
                //let a = address?.replacingOccurrences(of: ",", with: "")
                
            }
        }
    }
    func checkLocation(){
        self.checkLocationStatus { (isApproved) in
            if(isApproved == true){
                if LocationTracker.shared.isLocationAvailable == false{
                }
                else{
                    //self.getRestaurents()
                }
            }
            else{
                
            }
        }
    }
    
    //MARK: - MapView
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenterRegion(userLocation.coordinate)
        self.getAddress(userLocation.coordinate)
    }

    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
