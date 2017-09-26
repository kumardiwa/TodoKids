//
//  HomeViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 20/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
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
        let myLocationVC  = MyLocationViewController(nibName: "MyLocationViewController", bundle: nil)
        navigationController?.pushViewController(myLocationVC, animated: true)
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
        let createEventVC = CreateEventViewController(nibName: "CreateEventViewController", bundle: nil)
        navigationController?.pushViewController(createEventVC, animated: true)
    }
    @objc func attractionViewTapped(){
//        let createEventVC = CreateEventViewController(nibName: "CreateEventViewController", bundle: nil)
//        navigationController?.pushViewController(createEventVC, animated: true)
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

