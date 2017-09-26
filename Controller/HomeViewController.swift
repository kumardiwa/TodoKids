//
//  HomeViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 20/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import GooglePlaces

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var playGroundview: UIView!
    @IBOutlet weak var restaurentView: UIView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var attractionView: UIView!
    // MARK: - Properties

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkLocationStatus { (isApproved) in
            LocationTracker.shared.startUpdatingLocation()
        }
        setupLayouts()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup Layouts
    func setupNavigationItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_black_24dp"), style: .plain, target: self, action: #selector(menuButtonTouched))
    }
    func setupLayouts(){
        self.title = "Category"
        setupLocationButton()
        setupCategoryViews()
        //setupNavigationItem()
        setNavigationBarItem()
    }
    func setupLocationButton(){
        btnLocation.layer.cornerRadius = 6.0
    }
    func setupCategoryViews(){
        addTouchOnView(playGroundview, action: #selector(playgroundsViewTapped))
        addTouchOnView(restaurentView, action: #selector(restaurentViewTapped))
        addTouchOnView(eventsView, action: #selector(eventsViewtapped))
        addTouchOnView(attractionView, action: #selector(attractionViewTapped))
    }
    func addTouchOnView(_ categoryView : UIView, action : Selector?){
        let tap = UITapGestureRecognizer(target: self, action: action)
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        categoryView.addGestureRecognizer(tap)
    }

    // MARK: - Actions&Methods
    @objc func menuButtonTouched(){
        
    }
    @IBAction func locationButtonAction(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    

//        let myLocationVC  = MyLocationViewController(nibName: "MyLocationViewController", bundle: nil)
//        navigationController?.pushViewController(myLocationVC, animated: true)
    }
    @objc func playgroundsViewTapped(){
        let playGroundVC = PlayGroundsViewController(nibName: "PlayGroundsViewController", bundle: nil)
        navigationController?.pushViewController(playGroundVC, animated: true)
    }
    @objc func restaurentViewTapped(){
        let restaurantVC = RestaurantViewController(nibName: "RestaurantViewController", bundle: nil)
        navigationController?.pushViewController(restaurantVC, animated: true)
    }
    @objc func eventsViewtapped(){
        showEventAlertController()
    }
    @objc func attractionViewTapped(){
        showAttractionAlertController()
    }
    
    // MARK: - Action Controller
    func showEventAlertController()
    {
        let actionSheetController: UIAlertController = UIAlertController(title: "Select Events", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { void in
            print("Cancel")
        }
        let directionActionButton: UIAlertAction = UIAlertAction(title: "Museum Exhibitions", style: .default)
        { void in
            //            let navigationVC = NavViewController(source: LocationTracker.shared.coordinate!, destination: (self.selectedPlace?.coordinate)!)
            //            self.navigationController?.pushViewController(navigationVC, animated: true)
        }
        let detailsActionButton: UIAlertAction = UIAlertAction(title: "Theatre & Art Eventa", style: .default)
        { void in
            //self.editSharedUser()
        }
        let showWebSiteActionButton: UIAlertAction = UIAlertAction(title: "Art Gallery", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        actionSheetController.addAction(directionActionButton)
        actionSheetController.addAction(detailsActionButton)
        actionSheetController.addAction(showWebSiteActionButton)
        actionSheetController.addAction(cancelActionButton)
        //actionSheetController.addAction(favouriteActionButton)
        actionSheetController.view.tintColor = UIColor.navigationBarColor
        self.present(actionSheetController, animated: true, completion: nil)
        //let popPresenter = actionSheetController.popoverPresentationController
        
    }
    // MARK: - Action Controller
    func showAttractionAlertController()
    {
        let actionSheetController: UIAlertController = UIAlertController(title: "Select Attractions", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { void in
            print("Cancel")
        }
        let directionActionButton: UIAlertAction = UIAlertAction(title: "Aquarium", style: .default)
        { void in
            //            let navigationVC = NavViewController(source: LocationTracker.shared.coordinate!, destination: (self.selectedPlace?.coordinate)!)
            //            self.navigationController?.pushViewController(navigationVC, animated: true)
        }
        let detailsActionButton: UIAlertAction = UIAlertAction(title: "Zoo", style: .default)
        { void in
            //self.editSharedUser()
        }
        let showWebSiteActionButton: UIAlertAction = UIAlertAction(title: "Church", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        let favouriteActionButton: UIAlertAction = UIAlertAction(title: "City Hall", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        let libraryActionButton: UIAlertAction = UIAlertAction(title: "Library", style: .default)
        { void in
            //self.setSpeedLimitAction()
        }
        actionSheetController.addAction(directionActionButton)
        actionSheetController.addAction(detailsActionButton)
        actionSheetController.addAction(showWebSiteActionButton)
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(favouriteActionButton)
        actionSheetController.addAction(libraryActionButton)
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
extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
    
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        DKGoogleClass.shared.getCoordinateFromPlaceId(place.placeID) { (coordinate, error) in
            if error == nil{
                LocationTracker.shared.latitude = coordinate.latitude
                LocationTracker.shared.longitude = coordinate.longitude
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
