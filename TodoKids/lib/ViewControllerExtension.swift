//
//  ViewControllerExtension.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 23/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func showAlert(title : String, message : String, firstButtonTitle : String, secondButtonTitle : String? , completion : @escaping (_ buttonIndex : Int)-> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if secondButtonTitle != nil {
            
            let cancelAction = UIAlertAction(title: firstButtonTitle, style: .cancel, handler: { (action) in
                completion(0)
            })
            alertController.addAction(cancelAction)
            
            let secondAction = UIAlertAction(title: secondButtonTitle, style: .default) { (action) in
                ()
                completion(1)
            }
            alertController.addAction(secondAction)
        }
        else{
            let secondAction = UIAlertAction(title: firstButtonTitle, style: .default) { (action) in
                ()
                completion(0)
            }
            alertController.addAction(secondAction)
        }
        self.present(alertController, animated: true, completion: nil)
       
        
    }
    func openLocationSettings(){
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    func checkLocationStatus(completion : @escaping (_ isApproved : Bool)-> Void){
        let locationStatus = LocationTracker.shared.checkLocationStatus()
        switch locationStatus {
        case .access:
            completion(true)
            break
        case .noAccess:
            self.showAlert(title: "Location required", message: "You currently have no access for location services", firstButtonTitle: "OK", secondButtonTitle: "Change", completion: { (btnIndex) in
                if (btnIndex == 1){
                    self.openLocationSettings()
                }
            })
            completion(false)
            break
        case .notEnable:
            //
            self.showAlert(title: "Location required", message: "You currently have all location services for this device disabled", firstButtonTitle: "OK", secondButtonTitle: "Change", completion: { (btnIndex) in
                //
                if (btnIndex == 1){
                    self.openLocationSettings()
                }
                
            })
            completion(false)
            break
            
        }
    }
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        //self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        //self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
       // self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
       // self.slideMenuController()?.removeRightGestures()
    }
}
