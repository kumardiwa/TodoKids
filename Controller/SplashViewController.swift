//
//  SplashViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 26/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(gotoMainScreen), with: nil, afterDelay: 3.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func gotoMainScreen(){
        let appdelegate = AppDelegate.getAppDelegate()
        appdelegate.setupSliderMenu()
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
