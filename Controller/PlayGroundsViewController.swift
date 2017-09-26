//
//  PlayGroundsViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

class PlayGroundsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,LocationTrackerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var placeArray : [DKNearbyPlace] = []
    var placeRequested : Bool = false
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPlaces()
        setupLayouts()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - SetupLayouts
    func setupLayouts(){
        self.title = "Playgrounds"
    }
    
    // MARK: - TableViewDelegate&datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = placeArray[indexPath.row]
        let cell = Bundle.main.loadNibNamed("PlayGroundCell", owner: self, options: nil)?.first as! PlayGroundCell
        cell.selectionStyle = .none
        cell.setCellData(place)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showMoreAlertController()
    }
    
    // MARK: - Location
    func getPlaces(){
        self.checkLocationStatus { (isApproved) in
            if(isApproved == true){
                if LocationTracker.shared.isLocationAvailable == false{
                    SVProgressHUD.show(withStatus: "Fetching Location")
                    LocationTracker.shared.delegate = self
                    LocationTracker.shared.startUpdatingLocation()
                }
                else{
                    self.getPark()
                }
            }
            else{
                
            }
        }
    }
    
    func didUpdateLocation(_location: CLLocation) {
        if placeRequested == false {
            self.getPark()
            self.placeRequested = true
        }
    }
    
    // MARK: - Actions&Methods
    
    func getPark(){
        SVProgressHUD.show(withStatus: "Please wait...")
        DKGoogleClass.shared.getNearByPlaces(nil, type: .park) { (parks, errorStr) in
            self.placeArray = parks
            DispatchQueue.main.async {
                //self.getFoodPlaces()
                self.getNightClub()
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        }
    }
    func getNightClub(){
        DKGoogleClass.shared.getNearByPlaces(nil, type: .night_club) { (clubs, errorStr) in
            self.placeArray += clubs
            DispatchQueue.main.async {
                self.getCasiono()
                self.tableView.reloadData()
            }
        }
    }
    func getCasiono(){
        DKGoogleClass.shared.getNearByPlaces(nil, type: .casino) { (clubs, errorStr) in
            self.placeArray += clubs
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Action Controller
    func showMoreAlertController()
    {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { void in
            print("Cancel")
        }
        let directionActionButton: UIAlertAction = UIAlertAction(title: "Get direction", style: .default)
        { void in
//            let navigationVC = NavViewController(source: LocationTracker.shared.coordinate!, destination: (self.selectedPlace?.coordinate)!)
//            self.navigationController?.pushViewController(navigationVC, animated: true)
        }
        let detailsActionButton: UIAlertAction = UIAlertAction(title: "View place details", style: .default)
        { void in
            //self.editSharedUser()
        }
        let showWebSiteActionButton: UIAlertAction = UIAlertAction(title: "Go to web site", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        let favouriteActionButton: UIAlertAction = UIAlertAction(title: "Mark as favourite", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        actionSheetController.addAction(directionActionButton)
        actionSheetController.addAction(detailsActionButton)
        actionSheetController.addAction(showWebSiteActionButton)
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(favouriteActionButton)
        actionSheetController.view.tintColor = UIColor.navigationBarColor
        self.present(actionSheetController, animated: true, completion: nil)
        //let popPresenter = actionSheetController.popoverPresentationController
        
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
