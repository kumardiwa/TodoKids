//
//  LeftViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 20/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
enum LeftMenu: Int {
    case home = 0
    case search
    case about
    case fav
    case history
    case share
}
protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,LeftMenuProtocol {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var createEventView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    
    // MARK: - Properties
    var menus = ["Home", "Search", "About", "Favourites", "History","Share with friends"]
    var menuIcons = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "search"),#imageLiteral(resourceName: "about"),#imageLiteral(resourceName: "fav"),#imageLiteral(resourceName: "history"),#imageLiteral(resourceName: "share")]
    var homeViewcontroller: UIViewController!
    var searchViewController: UIViewController!
    var aboutViewController: UIViewController!
    var favouriteViewController: UIViewController!
    var historyViewController: UIViewController!
    //var shareViewController: UIViewController
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        setupViewcontrollers()
        setupLayouts()

        // Do any additional setup after loading the view.
    }
    func setupLayouts(){
        self.logoutView.layer.cornerRadius = 6
        self.createEventView.layer.cornerRadius = 6
        setupCreateEventView()
    }
    func setupCreateEventView(){
        let touch = UITapGestureRecognizer(target: self, action: #selector(createEventViewTouched))
        touch.numberOfTapsRequired = 1;
        touch.numberOfTouchesRequired = 1
        createEventView.addGestureRecognizer(touch)
        createEventView.isUserInteractionEnabled = true
    }
    func setupViewcontrollers(){
        let homeVC = HomeViewController()
        self.homeViewcontroller = UINavigationController(rootViewController: homeVC)
        let searchVC = SearchViewController()
        self.searchViewController = UINavigationController(rootViewController: searchVC)
        let aboutVC = AbautViewController()
        self.aboutViewController = UINavigationController(rootViewController: aboutVC)
        let favVC = FavouritesViewController()
        self.favouriteViewController = UINavigationController(rootViewController: favVC)
        let historyVC = HistoryViewController()
        self.historyViewController = UINavigationController(rootViewController: historyVC)
        //let shareVC = ShareViewController()
       // self.shareViewController = UINavigationController(rootViewController: shareVC)
    }
    
    // MARK: - TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LeftViewCell", owner: self, options: nil)?.first as! LeftViewCell
        cell.setCellData(title: menus[indexPath.row], icon: menuIcons[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.slideMenuController()?.changeMainViewController(self.homeViewcontroller, close: true)
        case .search:
            self.slideMenuController()?.changeMainViewController(self.searchViewController, close: true)
        case .about:
            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
        case .fav:
            self.slideMenuController()?.changeMainViewController(self.favouriteViewController, close: true)
        case .history:
            self.slideMenuController()?.changeMainViewController(self.historyViewController, close: true)
            
        case .share:
            print("Share")
            //self.slideMenuController()?.changeMainViewController(self.shareViewController, close: true)
        }
    }
    
    @objc func createEventViewTouched(){
        self.showAlert(title: "Pending", message: "API and design is pending", firstButtonTitle: "OK", secondButtonTitle: nil) { (btnIndex) in
            //
        }
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
