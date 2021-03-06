//
//  AppDelegate.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 20/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)
        addGoogleAPI()
        gotoSplashScreen()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func setupSliderMenu(){
       /* let mainViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()*/
        self.window?.rootViewController = nil
        self.window?.makeKeyAndVisible()
        setupNavigationBar()
        
        let mainViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let leftViewController = LeftViewController()


        let rightViewController = CreateEventViewController(nibName: "CreateEventViewController", bundle: nil)
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)

        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)

        //slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController

        window?.rootViewController = slideMenuController
    }
    func addGoogleAPI(){
    
        GMSPlacesClient.provideAPIKey(GoogleKeys.apiKey.rawValue)
        GMSServices.provideAPIKey(GoogleKeys.apiKey.rawValue)
    }
    func setupNavigationBar()
    {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        let navBackgroundImage:UIImage! = #imageLiteral(resourceName: "navbar-iphone") //UIImage(named:"navbar-iphone.png")
        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, for: .default)
        UITableViewCell.appearance().preservesSuperviewLayoutMargins = true
        UITableViewCell.appearance().contentView.preservesSuperviewLayoutMargins = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    func gotoSplashScreen(){
        let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        self.window?.rootViewController = splashVC
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TodoKids")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

