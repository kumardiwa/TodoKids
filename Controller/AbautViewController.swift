//
//  AbautViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 20/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit

class AbautViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

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
